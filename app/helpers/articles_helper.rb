module ArticlesHelper

	def search_articles(keyword)
      articles = Article.where(status: 2).tagged_with(keyword)
      if articles.empty?
        articles = Article.where(status: 2).where("title LIKE ? ", "%#{keyword}%")
      end
      articles
    end

end
