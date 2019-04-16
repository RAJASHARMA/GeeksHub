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
        unless image_params.nil?
          if@profile.image.nil?
            @profile.image = Image.new(image: image_params)
          else
            @profile.image.update(image: image_params)
          end
        end
        redirect_to @profile, :notice => 'Profile Updated Successfully'
  		else
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
  end

	private

  def set_profile
      @profile = Profile.find_by_id(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:name, :public_email, :location, :country, :profession, :organization, :facebook, :twitter, :instagram, :linkedin, :youtube, :bio)
  end

  def record_not_found
    render partial: "layouts/not_found", status: 404
  end

  def image_params
    params[:profile][:image]
  end

end
