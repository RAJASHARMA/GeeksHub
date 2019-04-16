module ProfilesHelper
	def update_picture
		img = params[:profile][:image]
	  	unless img.nil?
		  	profile = Profile.find_by_id(params[:id])
		  	if profile.image.nil?
		  		Image.create(:name => img.original_filename, :imageable_id => profile.id, :imageable_type => 'Profile')
		    else
		  		profile.image.update(:name => img.original_filename)
		  	end
		  	upload(img)
		  	
	  	end
	end

	def upload(img)
		File.open(Rails.root.join('public','profiles','images',img.original_filename),'wb') do |file|
	  		file.write(img.read)
	  	end
	end


end
