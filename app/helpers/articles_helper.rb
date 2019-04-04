module ArticlesHelper
	
	def save_picture
		img = params[:article][:image]
		unless img.nil?
		    Image.create(:name => img.original_filename, :imageable_id => @article.id, :imageable_type => 'Article')
		    upload(img)
		end
	end

	def update_picture
		img = params[:article][:image]
	  	unless img.nil?
		  	article = Article.find_by_id(params[:id])
		  	if article.image.nil?
		  		Image.create(:name => img.original_filename, :imageable_id => @article.id, :imageable_type => 'Article')
		    else
		  		article.image.update(:name => img.original_filename)
		  	end
		  	upload(img)
	  	end
	end

	def upload(img)
		File.open(Rails.root.join('public','articles','images',img.original_filename),'wb') do |file|
	  		file.write(img.read)
	  	end
	end

	def search_articles(keyword)
      articles = Article.where(status: 1).tagged_with("%#{keyword}%")
      if articles.empty?
        articles = Article.where(status: 1).where("title LIKE ?", "%#{keyword}%")
      end
      articles
    end

end
