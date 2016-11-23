class DivesitesController < ApplicationController
  before_action :find_divesite, only: [:show, :edit, :update, :destroy]



  def index
    @divesites = Divesite.all

    @hash = Gmaps4rails.build_markers(@divesites) do |divesite, marker|
      marker.lat divesite.latitude
      marker.lng divesite.longitude
      # marker.infowindow render_to_string(partial: "/divesites/map_box", locals: { divesite: divesite })
    end
  end

  def show
    # if @divesite.longitude && @divesite.latitude
    #   @hash = Gmaps4rails.build_markers(@divesite) do |divesite, marker|
    #     marker.lat divesite.latitude
    #     marker.lng divesite.longitude
    #   end
    # end
    @alert_message = "#{@divesite.name}"
    @divesite_coordinates = { lat: @divesite.latitude, lng: @divesite.longitude }
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
      :freshwater,
      #:photos,
      )
  end

  def build_markers(divesites)
    @hash = Gmaps4rails.build_markers(divesites) do |divesite, marker|
      marker.lat divesite.latitude
      marker.lng divesite.longitude
    end
  end
end
