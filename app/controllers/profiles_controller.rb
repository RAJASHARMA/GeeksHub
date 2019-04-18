class ProfilesController < ApplicationController
  include ProfilesHelper
  before_action :set_profile, only: [:edit, :show, :update, :destroy]


  def index
    if params[:val].present?
      @users = User.where(role: params[:val])
      unless @users.empty?
        @role = @users.first.role
      end
    else
      @users = User.all
      @role = 'user'
    end
    @users = @users.paginate(page: params[:page], per_page: 3)
  end

  def show
    
  end

  def edit

  end

  def update
      @profile.image.update(image: image_params)
      if @profile.update(profile_params)
        redirect_to @profile, :notice => 'Profile Updated Successfully'
      else
        render :show
      end
  end

  def rank
    user = User.find_by_id(params[:id])
    if user.user?
      user.moderator!
    elsif user.moderator?
      user.user!
    end
    redirect_to(:back)
  end

  private

  def set_profile
    @profile = Profile.friendly.find(params[:id])
  end

  def profile_params
    if @profile.slug.nil?
      params[:profile][:slug] = (params[:profile][:name] + "_" + params[:id]).capitalize if params[:profile][:name]
    end
    params.require(:profile).permit(:name, :public_email,
      :location, :country, :profession, :organization,
      :facebook, :twitter, :instagram, :linkedin, :youtube,
      :bio, :slug)
  end

  def record_not_found
    render partial: "layouts/not_found", status: 404
  end

  def image_params
    params[:profile][:image]
  end

end
