class ProfilesController < ApplicationController
  include ProfilesHelper
	before_action :set_profile, only: [:show, :update, :destroy]


	def index
		@profiles = Profile.all
	end

	def show
    if current_user.profile.nil?
        @profile = Profile.create(user_id: current_user.id)
        @profile.save
    end
	end

	def edit

	end

	def update
	 		if @profile.update(profile_params)
        update_picture
        redirect_to @profile, :notice => 'Profile Updated Successfully'
  		else
        render :edit
    	end
	end

	private

  def set_profile
    @profile = Profile.find_by_id(params[:id])
    if @profile.nil?
      @profile = Profile.find_by_user_id(params[:id])
    end
  end

  def profile_params
    params.require(:profile).permit(:name, :public_email, :location, :country, :profession, :organization, :bio)
  end

  def record_not_found
    render partial: "layouts/not_found", status: 404
  end

end
