class ArticlesController < ApplicationController
    include ArticlesHelper
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:index, :show]
    after_action :article_pagination, only: [:index, :user_articles]
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    def index
        if params[:tag]
            @articles = Article.approved.tagged_with(params[:tag]).order(created_at: :DESC)
            @tag = params[:tag]
        elsif params[:search]
            @articles = search_articles(params[:search])
            @search = params[:search]
        else
            @articles =  Article.approved.order(created_at: :DESC)  
        end
        article_pagination
    end

    def show
        @author = @article.user
    end

    def new
        @article = current_user.articles.new
    end

    def edit
    end

    def create
        @article = current_user.articles.new(article_params)
        @article.image = Image.new(image: image_params)
        respond_to do |format|
          if @article.save
              format.html { redirect_to @article, :notice => 'Article Created Successfully' }
              format.json { render :show, status: :created, location: @article }
          else
              format.html { render :new }
              format.json { render json: @article.errors, status: :unprocessable_entity }
          end
        end
    end

    def update
        respond_to do |format|
            if @article.update(article_params)
                if @article.image.nil?
                    @article.image = Image.new(image: image_params)
                else
                    @article.image.update(image: image_params)
                end
                format.html { redirect_to @article, :notice => 'Article Updated Successfully' }
                format.json { render :show, status: :ok, location: @article }
            else
                format.html { render :edit }
                format.json { render json: @article.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @article.destroy
        respond_to do |format|
            format.html { redirect_to articles_url, :notice => 'Article Destroyed Successfully' }
            format.json { head :no_content }
        end
    end

    def user_articles
        if params[:val]
            @articles = current_user.articles.where(:status => params[:val]).order(created_at: :DESC)
        else 
            @articles = current_user.articles.order(created_at: :DESC)
        end
        article_pagination
        render 'index'
    end

    def article_list
        if params[:status].present?
            @articles = Article.where(status: params[:status])
            unless @articles.empty?
                @status = @articles.first.status
            end
        else
            @articles = Article.all
            @status = 'all'
        end
        article_pagination
    end

    def modify_status
        article = Article.find(params[:id])
        if current_user.admin? || current_user.moderator?
            if params[:status]
                article.decline!
            else
                if current_user.admin?
                    article.approved!
                elsif current_user.moderator?
                    article.moderator_approved!
                end
            end
        end 
        redirect_to(:back)
        # respond_to do |format|
        #     format.html{ render '/' }
        #     format.js { render 'modify_status'}
        # end
    end

    private

        def set_article
            @article = Article.find(params[:id])
        end

        def article_params
            params.require(:article).permit(:title, :content, :status, :tag_list)
        end

        def tag_params
            params[:article]['tag_list']
        end

        def record_not_found
            render partial: 'layouts/not_found', status: 404
        end

        def article_pagination
            @articles = @articles.paginate(page: params[:page], per_page: 9)
        end

        def image_params
            params[:article][:image]
        end

end

