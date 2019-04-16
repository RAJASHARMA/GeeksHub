module ArticlesHelper
	
	def search_articles(keyword)
      articles = Article.includes(:comments, :user).approved.tagged_with(keyword)
      if articles.empty?
        articles = Article.includes(:comments, :user).approved.where("title LIKE ?", "%#{keyword}%")
      end
      articles
    end

end
