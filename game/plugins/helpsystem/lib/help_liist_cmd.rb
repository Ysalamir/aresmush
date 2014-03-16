module AresMUSH
  module HelpSystem
    
    class HelpListCmd
      include AresMUSH::Plugin
      attr_accessor :category
      
      no_switches
      
      def want_command?(client, cmd)
        HelpSystem.valid_commands.include?(cmd.root) && cmd.args.nil?
      end

      def crack!
        self.category = HelpSystem.category_for_command(cmd.root)
      end
      
      # TODO - Validate permissions
      
      def handle
        toc = HelpSystem.category_toc(self.category)
        text = ""
        toc.sort.each do |toc_key|
          text << "%r%xg#{toc_key.titleize}%xn"
          entries = HelpSystem.topics_for_toc(self.category, toc_key).sort
          entries.each do |entry_key|
            entry = HelpSystem.topic(self.category, entry_key)
            text << "%r     %xh#{entry_key.titleize}%xn - #{entry["summary"]}"
          end
        end
        title = t('help.toc', :category => HelpSystem.category_title(self.category))
        client.emit BorderedDisplay.text(text, title, false)
      end
    end
  end
end
