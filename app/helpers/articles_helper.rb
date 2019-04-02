module ArticlesHelper
	
	def save_picture
		img = params[:article][:image]
	  unless img.nil?
	    img_name = img.original_filename
	    Image.create(:name => img_name, :imageable_id => @article.id, :imageable_type => 'Article')
	    upload(img)
	  end
	end

	def update_picture
		img = params[:article][:image]
	  unless img.nil?
	  	article = Article.find_by_id(params[:id])
	  	article.image.update(:name => img.original_filename)
	  	upload(img)
	  end
	end

	def upload(img)
		File.open(Rails.root.join('public','articles','images',img.original_filename),'wb') do |file|
	  		file.write(img.read)
	  	end
	end
end
