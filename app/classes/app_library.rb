class AppLibrary
    include ActiveModel::Serialization
    
    attr_accessor :name
 
    def initialize(attributes = {})
        @name = attributes[:name]
    end
  
end