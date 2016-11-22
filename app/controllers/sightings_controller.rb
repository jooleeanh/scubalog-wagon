class SightingsController < ApplicationController
  before_action :find_dive, only: [:create]
  before_action :find_sighting, only: [:update, :destroy]

  def create
    @sighting = @dive.sightings.new(sighting_params)
    @sighting.save
    # TODO: if, redirect, render?
  end

  def update
    @sighting.update(sighting_params) # animal_id and dive_id already permitted?
  end

  def destroy
    @sighting.destroy
  end

  private

  def find_sighting
    @sighting = Sighting.find(params[:id])
  end

  def find_dive
    @dive = Dive.find(params[:dive_id])
  end

  def sighting_params
    params.require(:sighting).permit(:animal_id)
  end
end
