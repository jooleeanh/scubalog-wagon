class ParticipationsController < ApplicationController
  before_action :find_event, only: [:create]
  before_action :find_participation, only: [:update, :destroy]

  def new
    @participation = Participation.new
  end

  def create
    @participation = current_user.participations.new
    @participation.event = @event
    if @participation.save
    # TODO: if, redirect, render?
      redirect_to @event
    else
      render 'event/show'
    end
  end

  def update
    @participation.update(participation_params) # user_id and dive_id already permitted?
  end

  def destroy
    @event = @participation.event
    @participation.destroy
    redirect_to @event
  end

  private

  def find_participation
    @participation = Participation.find(params[:id])
  end

  def find_event
    @event = Event.find(params[:event_id])
  end
end
