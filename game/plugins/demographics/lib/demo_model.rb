module AresMUSH
  class Character
    attribute :height
    attribute :physique
    attribute :skin
    attribute :fullname
    attribute :gender
    attribute :hair
    attribute :eyes
    attribute :birthdate, DataType::Time
    attribute :callsign
    
    before_create :set_default_demographics
    
    def set_default_demographics
      self.gender = "Other"
    end
    
    def age
      Demographics.calculate_age(self.birthdate)
    end
    
    def demographic(name)
      case name
      when :height, :physique, :skin, :fullname, :gender, :hair, :eyes, :birthdate, :callsign
        return self.send(name)
      else
        return ""
      end
    end
  end
end