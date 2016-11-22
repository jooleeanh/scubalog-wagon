class DivesController < ApplicationController
before_action :set_dive, only: [:show, :edit, :update, :destroy]
# before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @dives = Dive.all
  end

  def show
  end

  def new
    @dive = Dive.new
    @divesites = Divesite.all
  end

  def create
    @dive = current_user.dives.new(dive_params)
    if @dive.save
      flash[:notice] = "Dive successfully created."
      redirect_to user_dives_path
    else
      flash[:alert] = "Please review your dive form for errors."
      # render :new
    end
  end

  def edit
    @divesites = Divesite.all
  end

  def update
    if @dive.update(dive_params)
      flash[:notice] = "Dive successfully updated."
      redirect_to user_dives_path
    else
      flash[:alert] = "Please review your dive form for errors."
      # redirect_to
    end
  end

  def destroy
    @dive.destroy
    redirect_to user_dives_path
  end

  private

  def set_dive
    @dive = Dive.find(params[:id])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def dive_params
    params.require(:dive).permit(:user_id, :divesite_id, :datetime, :type, :tank_size, :bottom_time, :start_air, :end_air, :max_depth, :avg_depth, :min_temp, :max_temp, :comments, :enjoyment, :visibility, :review_rating, :review_content)
  end
end

