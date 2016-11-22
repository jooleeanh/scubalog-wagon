class DataPointsController < ApplicationController
  before_action :find_dive, only: [:create]

  def create
    @data_point = @dive.data_points.new(data_point_params)
    @data_point.save
    # TODO: if, redirect, render?
  end

  private

  def find_dive
    @dive = Dive.find(params[:dive_id])
  end

  def data_point_params
    params.require(:data_point).permit(:time, :depth, :temp, :air)
  end
end
