class ArticlesController < ApplicationController
  require 'net/http'
  require 'net/https'

  before_action :set_article, only: [:edit, :update, :destroy, :modify_status]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_user, only: [:user_articles]
  # after_action :article_pagination, only: [:index, :user_articles, :article_list]

  autocomplete :article, :title, :full => true
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    if params[:tag]
      @articles = Article.approved.tagged_with(params[:tag])
          .order(created_at: :DESC)
          .includes([user: [profile: :image]], :image, :content_average)
      @articles
      @tag = params[:tag]
    elsif params[:search]
      @articles = Article.search(params[:search])
          .includes([user: [profile: :image]], :image, :content_average)
      @articles
      @search = params[:search]
    else
      @articles =  Article.approved.order(created_at: :DESC)
          .includes([user: [profile: :image]], :image, :content_average)
      @articles
    end
    article_pagination
  end

  def show
    @article = Article.includes([comments: [user: [profile: :image]]], :image).friendly.find(params[:id])

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
        format.js
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      unless image_params.nil?
        @article.image.update(image: image_params)
      end
      if @article.update(article_params) 
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

  # This function will return list of articles created by a particular user
  def user_articles
    if params[:val]
      @articles = @user.articles
      .where(:status => params[:val]).order(created_at: :DESC)
      .includes(:image, :content_average, :user)
    else 
      @articles = @user.articles.order(created_at: :DESC)
      .includes(:image, :content_average, :user)
    end
    article_pagination
    render 'index'
  end

  # This function will filter the article list with provided status
  def article_list
    if params[:status].present?
      @articles = Article.includes(:user, :image, :reports, :taggings)
      .friendly.where(status: params[:status])
      unless @articles.empty?
          @status = @articles.first.status
      end
    else
      @articles = Article.includes(:user, :image, :reports, :taggings).friendly.all
      @status = 'all'
    end
    article_pagination
  end

  # This function will modify the status of the article 
  def modify_status
      # article = Article.friendly.find(params[:id])
    if params[:status]
      @article.declined!
    else
      if current_user.admin?
        @article.approved!
      elsif current_user.moderator?
        @article.moderator_approved!
      end
    end
    redirect_to(:back)
  end

  def execute_code
    @response = {:output => "", :cpuTime => "", :memory => "", :statusCode => ""}
    puts "\n\nSever function called successfully\n"
    puts params
    # run_Jdoodle_API
    run_GeeksforGeeks_API       
    render json: @response  
  end

  private

    def set_article
      @article = Article.friendly.find(params[:id])
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
      @articles = @articles.paginate(page: params[:page], per_page: 21)
    end

    def image_params
      params[:article][:image]
    end

    def set_user
      @user = User.includes(:profile).find_by_id(params[:user_id])
    end


    def run_Jdoodle_API
      puts "\nJdoodle API response\n"

      begin
        url = URI("https://api.jdoodle.com/v1/execute")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Post.new(url.path)
        request["Content-Type"] = 'application/json'
        request.body = {
            "script" => params[:code],
            "language" => params[:lang],
            "versionIndex" => params[:version],
            "clientId" => "**************************************",
            "clientSecret" => "****************************************************************"
        }.to_json
        response = http.request(request)

        res = JSON.parse(response.read_body)
        if (res["memory"] == nil || res["cpuTime"] == nil) &&  res["statusCode"] == 200
            res["output"].slice!(1,7)
            res["output"].insert(1,"GeeksHub")
        elsif res["statusCode"] != 200
           res.merge!("output" => "Oops Error in Ecxecution..")
        end
        @response = res
        puts res
      rescue => e
        puts "Failed in calling Jdoodle: #{e}"
      end
    end


    def run_GeeksforGeeks_API
      puts "\nGeeksforGeeks_API response\n"
      code = params[:code]
      lang = params[:lang].capitalize
      
      begin
        url = URI("https://ide.geeksforgeeks.org/main.php")

        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Post.new(url)
        request["Content-Type"] = 'application/json'
        request["content-type"] = 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW'
        request.body = "------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"code\"\r\n\r\n#{code}\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"lang\"\r\n\r\n#{lang}\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW--"
        response = http.request(request)

        res = JSON.parse(response.read_body)
        @response[:output] = res["output"] + res["rntError"] + res["cmpError"]
        @response[:cpuTime] = res["time"]
        @response[:memory] = res["memory"]
        puts res
      rescue => e
        puts "Failed in calling GeeksforGeeks: #{e}"
      end
    end
end