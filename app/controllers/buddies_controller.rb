class BuddiesController < ApplicationController
  before_action :find_dive, only: [:create]
  before_action :find_buddy, only: [:update, :destroy]

  def create
    @buddy = @dive.buddies.new(buddy_params)
    @buddy.save
    # TODO: if, redirect, render?
  end

  def update
    @buddy.update(buddy_params) # user_id and dive_id already permitted?
  end

  def destroy
    @buddy.destroy
  end

  private

  def find_buddy
    @buddy = Buddy.find(params[:id])
  end

  def find_dive
    @dive = Dive.find(params[:dive_id])
  end

  def buddy_params
    params.require(:buddy).permit(:user_id)
  end
end
