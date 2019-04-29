class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception
    before_action :popular_articles
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :popular_articles
    before_action :new_reports

    def new_reports
      @new_reports = Report.select(:article_id).distinct.last(5)
      @total = @new_reports.inject(0) {|total, report| total + report.article.reports.count }
    end

    protected
    
    def configure_permitted_parameters
         devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password)}
         # devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :public_email, :location, :country, :profession, :organization, :password, :password_confirmation, :current_password)}
    end

    def popular_articles
      @popular_articles  = Article.joins(:content_average)
        .approved.order('rating_caches.avg DESC')
        .includes(:image, :user)
        .limit(5)
    end

end
