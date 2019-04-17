class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_article


  def new
    # @comment = @article.comments.new(:parent_id => params[:parent_id])
  end


  def create
    @comment = @article.comments.new(comment_params)
    respond_to do |format|
      if @comment.save
        # byebug
          # save_picture
          format.html { redirect_to @article, :notice => 'Article Created Successfully' }
          format.js
      else
          format.html { render :new }
          format.js { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_to @article, :notice => 'Comment destroyed Successfully.' }
        format.js
      end
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:content, :parent_id).merge(user_id: current_user.id)
    end

    def find_article
      @article = Article.friendly.find(params[:article_id])
    end
end





























#   def new
#     @comment = Comment.new
#   end

#   def create
#     @comment = @commentable.comments.new(find_comment)
#     if @comment.valid?
#       @comment.parent_id = params[:comment_id] if params[:controller] == "comments"
#       @comment.article_id = get_article_id 
#       @comment.user_id = current_user.id
#       if @comment.save
#         redirect_to :back
#       else
#         render nothing: true
#       end
#     else
#       redirect_to :back, :alert => 'Comment must be within 2-300 characters.'
#     end
#   end

#   def destroy
#     @comment.destroy
#     redirect_to article_path(@article)
#   end

#   private

#     def get_article_id
#       params[:comment][:article_id] ? params[:comment][:article_id] : params[:article_id]
#     end
    
#     def find_article
#       @article = Article.find(params[:article_id]) 
#     end

#     def find_comment
#       params.require(:comment).permit(:content)
#     end

#     def find_commentable
#       @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
#       @commentable = Article.find_by_id(params[:article_id]) if params[:article_id]
#     end

#     def find_deleteable_comment
#       @comment = Comment.find_by_id(params[:comment_id])
#       @article = Article.find_by_id(params[:article_id])
#     end

# end



















































# class CommentsController < ApplicationController
#   before_action :set_comment, only: [:show, :edit, :update, :destroy]
#   before_action :find_articles, only: [:create,:destroy]
#   # GET /comments
#   # GET /comments.json
#   def index
#     @comments = @article.comments.all
#   end

#   # GET /comments/1
#   # GET /comments/1.json
#   def show
#   end

#   # GET /comments/new
#   def new
#     @comment = @article.comments.new
#   end

#   # GET /comments/1/edit
#   def edit
#   end

#   # ARTICLE /comments
#   # ARTICLE /comments.json
#   def create
#     @comment = @article.comments.create('content' => params[:comment]['content'])
#     if @comment.valid?

#       @comment.user_id = current_user.id
#       if @comment.save
#         redirect_to articles_path(@articles)
#       else
#         render nothing: true
#       end
#     else
#       redirect_to articles_path(@articles), :alert => 'Comment must be within 2-200 characters.'
#     end
#   end

#   # PATCH/PUT /comments/1
#   # PATCH/PUT /comments/1.json
#   # def update
#   #   respond_to do |format|
#   #     if @comment.update(comment_params)
#   #       format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
#   #       format.json { render :show, status: :ok, location: @comment }
#   #     else
#   #       format.html { render :edit }
#   #       format.json { render json: @comment.errors, status: :unprocessable_entity }
#   #     end
#   #   end
#   # end

#   # DELETE /comments/1
#   # DELETE /comments/1.json
#   def destroy
#     # @articles = articles.find(params[:articles_id])
#     @comment = @articles.comments.find(params[:id])
#     @comment.destro y
#     redirect_to articles_path(@articles)
#   end

#   private
    
#   def find_articles
#     @article = Article.find_by_id!(params[:article_id]) 
#   end

  
#     # Use callbacks to share common setup or constraints between actions.
#     def set_comment
#       @comment = Comment.find(params[:id])
#     end

#     # # Never trust parameters from the scary internet, only allow the white list through.
#     # def comment_params
#     #   params.require(:comment).permit(:content, :article_id, :user_id)
#     # end
# end
