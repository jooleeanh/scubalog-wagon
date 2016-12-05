class DivesController < ApplicationController
  before_action :set_dive, only: [:show, :edit, :update, :destroy]
  before_action :all_divesites, only: [:new, :create, :edit, :update, :destroy]
  before_action :all_animals, only: [:new, :create]
  skip_before_action :authenticate_user!, only: [:show]
  def index
    @dives = current_user.dives.all.recent
    @dive = @dives.first
    build_markers(@dives)
  end

  def show
    build_markers(@dive)
    @splitted_animals = split_animals(@dive.sightings)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @dive = Dive.new
  end

  def create
    @dive = current_user.dives.new(dive_params)
    if @dive.save
      flash[:notice] = "Dive successfully created."
      redirect_to @dive
    else
      flash[:alert] = "Please review your dive form for errors."
      render :new
    end
  end

  def edit
  end

  def update
    if @dive.update(dive_params)
      flash[:notice] = "Dive successfully updated."
      redirect_to @dive
    else
      flash[:alert] = "Please review your dive form for errors."
      render :edit
    end
  end

  def destroy
    @dive.destroy
    redirect_to dives_path
  end

  private

  def set_dive
    @dive = Dive.find(params[:id])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def all_divesites
    @divesites = Divesite.order_by_name
  end

  def all_animals
    @animals = Animal.order_by_name
  end

  def dive_params
    params.require(:dive).permit(:user_id, :divesite_id, :datetime, :types, :tank_size, :bottom_time, :start_air, :end_air, :max_depth, :avg_depth, :min_temp, :max_temp, :comments, :enjoyment, :visibility, :review_rating, :review_content, animal_ids: [], photos: [])
  end

  def divesites_with_location(dives)
    dives.joins(:divesite)
  end

  def build_markers(dives)
    @hash = Gmaps4rails.build_markers(dives) do |dive, marker|
      marker.lat dive.divesite.latitude
      marker.lng dive.divesite.longitude
      marker.infowindow render_to_string(partial: "/dives/map_box", locals: { dive: dive })
    end
  end
end
