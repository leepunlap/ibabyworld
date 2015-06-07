module Extensions

    def to_hash
        # hash = {}; self.attributes.each { |k,v| hash[k] = v }
        hash = Hash[ self.attributes.map{ |x, y| [x, y] } ]

        return hash.except!("password", "new_password")
    end

    def except!(*keys)
    	return hash.delete_if { |k| keys.include? k }
  	end
  
end