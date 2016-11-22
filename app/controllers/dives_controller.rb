class DivesController < ApplicationController
before_action :set_dive, only: [:show, :edit, :update, :destroy]
before_action :set_user, only: [:new, :create]
# before_action :set_divesite, only: [:create]
  def index
    @dives = Dive.all
  end

  def show
  end

  def new
    @dive = Dive.new
  end

  def create
    @dive = @user.dives.new(dive_params)
    @dive.divesite = @divesite
    if @dive.save
      flash[:notice] = "Dive successfully created."
      # redirect_to user_dives_path
    else
      flash[:alert] = "Please review your dive form for errors."
      render :new
    end
  end

  def edit
  end

  def update
    @dive.update(dive_params)
    # redirect_to
  end

  def destroy
    @dive.destroy
    # redirect_to
  end

  private

  def set_dive
    @dive = Dive.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_divesite
    @divesite = Divesite.find(params[:divesite_id])
  end

  def dive_params
    params.require(:dive).permit(:user, :divesite, :datetime, :type, :tank_size, :bottom_time, :start_air, :end_air, :max_depth, :avg_depth, :min_temp, :max_temp, :comments, :enjoyment, :visibility, :polygon, :review_rating, :review_content)
  end
end

