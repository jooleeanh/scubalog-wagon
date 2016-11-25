class DivesitesController < ApplicationController
  before_action :find_divesite, only: [:show, :edit, :update, :destroy]

  def index
    if params[:search_input].blank?
      @divesites = Divesite.order_by_name
      build_markers(divesites_with_location(@divesites))
    elsif Divesite.near(params[:search_input], 100).blank?
      flash[:alert] = "Aucun spot proche de #{params[:search_input].capitalize} :("
      redirect_to root_path
    else
      @divesites = Divesite.order_by_name.near(params[:search_input].capitalize, 100)
      build_markers(divesites_with_location(@divesites))
    end
      # marker.infowindow render_to_string(partial: "/divesites/map_box", locals: { divesite: divesite })
  end

  def search
    respond_to do |format|
    format.html
    format.json { @divesites = Divesite.search(params[:term]) }
    end
  end

  def show
    if @divesite.longitude && @divesite.latitude
      @hash = Gmaps4rails.build_markers(@divesite) do |divesite, marker|
        marker.lat divesite.latitude
        marker.lng divesite.longitude
      end
    end
    @alert_message = "#{@divesite.name}"
    @divesite_coordinates = { lat: @divesite.latitude, lng: @divesite.longitude }
    @splitted_animals = split_animals(@divesite.sightings)
  end

  def new
    @divesite = Divesite.new
  end

  def create
    @divesite = Divesite.new(divesite_params)
    if @divesite.save
      flash[:notice] = "Divesite has been added!"
      redirect_to @divesite
    else
      render 'divesites/new'
    end
  end

  def edit
  end

  def update
    if @divesite.update_attributes(divesite_params)
      flash[:notice] = "Divesite has been updated!"
      redirect_to @divesite
    else
      render 'divesites/edit'
    end
  end

  def destroy
    @divesite.destroy
    redirect_to @divesites
  end

  private

  def find_divesite
    @divesite = Divesite.find(params[:id])
  end

  def divesite_params
    params.require(:divesite).permit(
      :name,
      :location,
      :longitude,
      :latitude,
      :difficulty,
      :max_depth,
      :avg_depth,
      :freshwater
      #:photos,
      )
  end


  def divesites_with_location(divesites)
    divesites.where.not(latitude: nil, longitude: nil)
  end

  def build_markers(divesites)
    @hash = Gmaps4rails.build_markers(divesites) do |divesite, marker|
      marker.lat divesite.latitude
      marker.lng divesite.longitude
    end
  end

  def gmaps4rails_marker_picture
    {
     "picture" => "/images/icon.png",
     "width" => 20,
     "height" => 20,
     "marker_anchor" => [ 5, 10],
     "shadow_picture" => "/images/morgan.png" ,
     "shadow_width" => "110",
     "shadow_height" => "110",
     "shadow_anchor" => [5, 10],
    }
  end

end
