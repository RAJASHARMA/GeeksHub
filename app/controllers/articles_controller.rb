class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /articles
  # GET /articles.json
  def index
      # byebug
      @articles = params[:tag].present? ? Article.where(:status => 1).tagged_with(params[:tag]) : Article.where(:status => 1)
      @articles = @articles.paginate(page: params[:page], per_page: 6)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = current_user.articles.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.new(article_params)

    respond_to do |format|
      if @article.save
        @article.tag_list.add(tag_params)
        format.html { redirect_to @article, :notice => 'Article Created Successfully' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        @article.tag_list.add(tag_params)
        format.html { redirect_to @article, :notice => 'Article Updated Successfully' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, :notice => 'Article Destroyed Successfully' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :status, :tag_list)
    end

    def tag_params
      params.require(:article).permit(:tag_list)['tags']
    end

    def record_not_found
      render plain: "404 Not Found", status: 404
    end
end
