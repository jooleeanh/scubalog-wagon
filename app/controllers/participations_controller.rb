class ParticipationsController < ApplicationController
  before_action :find_user, only: [:create]
  before_action :find_participation, only: [:update, :delete]

  def create
    @participation = @user.participations.new(participation_params)
    @participation.save
    # TODO: if, redirect, render?
  end

  def update
    @participation.update(participation_params) # user_id and dive_id already permitted?
  end

  def delete
    @participation.destroy
  end

  private

  def find_participation
    @participation = Participation.find(params[:id])
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def participation_params
    params.require(:participation).permit(:event_id)
  end

end
