module AresMUSH
  module Groups
    class GenderCensusTemplate < ErbTemplateRenderer
            
      attr_accessor :chars
      
      def initialize
        super File.dirname(__FILE__) + "/gender_census.erb"
      end
      
      def census
        Groups.census_by { |c| c.demographic(:gender) }
      end      
    end
  end
end
