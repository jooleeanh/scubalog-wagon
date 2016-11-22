class DivesController < ApplicationController
before_action :set_dive, only: [:show, :edit, :update, :destroy]

  def index
    @dives = Dive.all
  end

  def show
  end

  def new
    @dive = Dive.new
    @user = current_user
  end

  def create
    # user = current_user
    @dive = current_user.dives.new(dive_params)
    if @dive.save
      flash[:notice] = "Dive successfully created."
      redirect_to @dive.user
    else
      flash[:alert] = "Please review your dive form for errors."
      render 'dives/show'
    end
  end

  def edit
  end

  def update
    @dive.update(dive_params)
  end

  def destroy
    @dive.destroy
    redirect_to
  end

  private

  def set_dive
    @dive = Dive.find(params[:id])
  end

  def set_divesite
    @divesite = Divesite.find(params[:divesite_id])
  end

  def dive_params
    params.require(:dive).permit(:name, :user_id)
  end
end
