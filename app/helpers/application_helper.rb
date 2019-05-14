module ApplicationHelper

  def show_errors(object, field_name)
    if object.errors.any?
      if !object.errors.messages[field_name].blank?
        object.errors.messages[field_name].join(", ")
      end
    end
  end 


  def get_user_name(profile)
    if !profile.name.nil?
      profile.name
    elsif !profile.public_email.nil?
      profile.public_email.split('@')[0]
    else
      profile.user.email.split('@')[0]
    end
  end
  
end
