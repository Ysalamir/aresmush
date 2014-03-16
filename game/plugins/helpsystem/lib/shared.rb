module AresMUSH
  module HelpSystem
    
    def self.categories
      Global.config["help"]["categories"]
    end
        
    def self.topics(category)
      HelpSystem.category(category)["topics"]
    end
    
    def self.valid_commands
      HelpSystem.categories.values.map { |c| c["command"] }
    end
    
    def self.category_for_command(command_root)
      HelpSystem.categories.keys.find { |k| categories[k]["command"].upcase == command_root.upcase }
    end
    
    def self.category_toc(name)
      topics = HelpSystem.topics(name)
      toc = topics.values.map { |t| t["toc_topic"] }
      toc.uniq
    end
    
    def self.topics_for_toc(category, toc)
      topics = HelpSystem.topics(category)
      topics.keys.select { |t| topics[t]["toc_topic"] == toc }
    end
    
    def self.category_title(name)
      category = HelpSystem.category(name)
      title = category.nil? ? "" : category["title"]
      title
    end
    
    def self.lookup_alias(category, topic)
      topics = HelpSystem.topics(category)
      return nil if topics.nil?
      topics.keys.find { |t| !topics[t]['aliases'].nil? && topics[t]['aliases'].include?(topic.downcase) }
    end

    def self.search_help(category, topic)
      topics = HelpSystem.topics(category)
      return [] if topics.nil?
      downcased_topic_keys = topics.keys.map(&:downcase)
      downcased_topic = topic.downcase
      matching_topics = downcased_topic_keys.select { |k| k =~ /#{downcased_topic}/ }
      matching_topics.map { |k| k.titlecase }
    end
    
    def self.load_help(category, topic_key)
      topic = HelpSystem.topic(category, topic_key)
      return nil if topic.nil?
      filename = topic["file"]
      filename.nil? ? nil : File.read(filename)
    end
    
    # Careful with this one - name must be pre-stripped if user input
    def self.category(name)
      categories[name.downcase]
    end

    # Careful with this one - name must be pre-stripped if user input
    def self.topic(category, topic)
      HelpSystem.category(category)["topics"][topic.downcase]
    end
    
  end
end
