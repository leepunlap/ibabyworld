module GlobalHelper
	require 'app_library'

    # require 'user'
    @@dir_uploads = "public/uploads"
    @@dir_articles = @@dir_uploads +"/articles"
    @@dir_members = @@dir_uploads +"/members"

	@@response_errors = {
        "Bad request" => 400,
        "Unauthorized request" => 401,
        "Record Not Found" => 404,
        "Method Not Allowed" => 405,
        "Conflict found" => 409,
        "Authentication timeout" => 419
    }

    def initialize_variables
    end

    def app_name
        "iBabyWorld"
    end

    def tags_only(tags)
        @tags_only = Array.new

        if !params[:tags].nil?
            @tags = JSON.parse(tags)

            @tags.each do |tag|
                @tags_only.push(tag['text'])
            end
            
            @tags_only = @tags_only.join(", ")
        end
    end
    
	def response_json(body, code)
		render :json => body, :except => [:password], :status => code
    end
    
    def response_success(body)
    	description = {
    		"status" => "Success",
    		"description" => "Successful requests",
    	}

        if body == nil
            response_json(description, 200)
            return
        end

    	response_json((description).merge!(body), 200)
    end

    def response_error(description)
        code = @@response_errors[description]
        body = { 
            "status" => "Failed", 
            "description" => description
        }

        response_json(body, code)
    end

    def response_error_body(description, code)
        body = { 
            "status" => "Failed", 
            "description" => description
        }

        response_json(body, code)
    end

    def response_error_by_code(code)
        description = @@response_errors.key(code)

        response_error(description)
    end

    def response_validation_errors(errors)
    	errors.each do |field, descriptions|
    		response_error(descriptions.first)
        	return
		end
    end

    def response_not_found
        
    end
	
end