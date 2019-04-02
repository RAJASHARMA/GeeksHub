module ApplicationHelper
	
	def has_role?(role)
		current_user && current_user.has_role?(role)
	end

	def show_errors(object, field_name)
	  	if object.errors.any?
	    	if !object.errors.messages[field_name].blank?
	      		object.errors.messages[field_name].join(", ")
	    	end
	  	end
	end 

end
