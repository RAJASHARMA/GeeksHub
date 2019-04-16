class ApplicationController < ActionController::Base

    protect_from_forgery with: :exception
    before_action :popular_articles
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :popular_articles

    protected
    
    def configure_permitted_parameters
         devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password)}
         # devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :public_email, :location, :country, :profession, :organization, :password, :password_confirmation, :current_password)}
    end

    def popular_articles
      @popular_articles  = Article.joins(:content_average).approved.order('rating_caches.avg DESC').limit(5)
    end

end
