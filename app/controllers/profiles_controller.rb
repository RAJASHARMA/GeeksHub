class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :show, :update, :destroy, :rank_request ]

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  def index
    if params[:val].present?
      @users = User.includes([profile: :image]).where(role: params[:val])
      unless @users.empty?
        @role = @users.first.role
      end
    else
      @users = User.includes([profile: :image]).all
      @role = 'user'
    end
    user_paginate
  end

  def show
  end

  def update
      @profile.image.update(image: image_params)
      if @profile.update(profile_params)
        if @profile.slug.nil?
          @profile.update(slug: @profile.name.split(" ")[0] + "_" + @profile.id).capitalize if !@profile.name.nil?
        end
        redirect_to @profile, :notice => 'Profile Updated Successfully'
      else
        render :show
      end
  end

  def rank
    # byebug
    user = User.find_by_id(params[:id])
    if user.user? || user.moderator_request? 
      user.moderator!
      user.update(moderator_request: false)
    elsif user.moderator?
      user.user!
    end
    redirect_to(:back)
  end

  def rank_request
    user = User.find_by_id(params[:user_id])
    if user.update(moderator_request: true)
      respond_to do |format|
        format.html{ redirect_to @profile, :notice => "Your Request Sent Successfully"}
        format.js
      end
    end
  end

  private

  def set_profile
    @profile = Profile.friendly.find(params[:id])
  end

  def profile_params
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

  def user_paginate
    @users = @users.paginate(page: params[:page], per_page: 20)
  end
end
