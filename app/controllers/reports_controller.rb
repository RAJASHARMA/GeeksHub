class ReportsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_article, except: [:update_notice_board]
    before_action :set_report, only: [:destroy]
    # after_action :new_reports, only: [:destroy]

    def index
        @reports = @article.reports.includes([user: :profile])
        unless @reports.nil?
            report_pagination
        end
    end

    def new
    end

    def create
        @report = @article.reports.new(report_params)
        respond_to do |format|
            if @report.save
                format.html { redirect_to @article, :notice => 'Reported Successfully' }
                format.js
            else
                format.html { render :new }
                format.js { render json: @report.errors, status: :unprocessable_entity }
            end 
        end
    end

    def destroy
        if @report.destroy
            respond_to do |format|
                format.html {redirect_to(:back)}
                format.js
            end
        end    
    end

    def update_notice_board
        new_reports
        data = {}
        puts "Update report called Successfully.................."

        data.merge!(:total => @total)
        data.merge!(:new_reports => JSON.parse(@new_reports.to_json))
        data[:new_reports].each do |report|
            article = Article.find_by_id(report["article_id"])
            report.merge!(:title => article.title, :slug => article.slug, :reports => article.reports.count)
        end
        render json: data
    end

    private

        def set_report
            @report = Report.find_by_id(params[:id])
        end

        def report_params
            params.require(:report).permit(:description).merge(user_id: current_user.id)
        end

        def find_article
          @article = Article.friendly.find(params[:article_id])
        end

        def report_pagination
            @reports = @reports.paginate(page: params[:page], per_page: 20)
        end
end 

# {"total" => "3", "new_reports"{report_id = "nul", article_id = 11, title, slug}}