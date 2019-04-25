class ReportsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_article
    before_action :set_report, only: [:destroy]

    def index
        @reports = @article.reports
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
end 
