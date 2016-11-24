class EventsController < ApplicationController
  before_action :find_event, only: [:show, :edit, :destroy]
  before_action :find_divesite, only: [:create, :update, :index, :edit, :destroy]

  def index
    @event = Event.all

  end

  def show
    if @event.divesite.longitude && @event.divesite.latitude
      @hash = Gmaps4rails.build_markers(@event.divesite) do |divesite, marker|
        marker.lat @event.divesite.latitude
        marker.lng @event.divesite.longitude
      end
    end
    @alert_message = "#{@event.divesite.name}"
    @divesite_coordinates = { lat: @event.divesite.latitude, lng: @event.divesite.longitude }
  end

  def new
    @event = Event.new
  end

  def create
    @event = @divesite.events.new(event_params)
    @event.user = current_user
    if @event.save
      redirect_to @divesite
    else
      flash[:alert] = "Your event cannot be confirmed"
      render :new
    end
  end

  def edit
  end

  def update
    @event = event.find(params[:id])
    if @event.update(event_params)
      flash[:notice] = "Event created!"
      redirect_to @user
    else
      render :new
    end
  end

  def destroy
    @event.destroy
  end

  private

  def event_params
    params.require(:event).permit(:datetime)
  end

  def find_divesite
    @divesite = Divesite.find(params[:divesite_id])
  end

  def find_event
    @event = Event.find(params[:id])
  end
end
