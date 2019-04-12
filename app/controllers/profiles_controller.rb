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
	 		if @profile.update(profile_params)
        update_picture
        redirect_to @profile, :notice => 'Profile Updated Successfully'
  		else
        # byebug
        render :edit
    	end
	end

  def rank
    user = User.find_by_id(params[:id])
    if user.user?
      user.moderator!
    elsif user.moderator?
      user.user!
    end
    redirect_to profiles_path
  end

	private

  def set_profile
      @profile = Profile.find_by_id(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:name, :public_email, :location, :country, :profession, :organization, :bio)
  end

  def record_not_found
    render partial: "layouts/not_found", status: 404
  end

end
