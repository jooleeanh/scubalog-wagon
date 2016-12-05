class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  def show
    @user = User.find(params[:id])
    build_markers(@user.dives)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    if @user.destroy
      redirect_to root_url, notice: "User deleted."
    end

  end

private

  def build_markers(dives)
    @hash = Gmaps4rails.build_markers(dives) do |dive, marker|
      marker.lat dive.divesite.latitude
      marker.lng dive.divesite.longitude
      marker.infowindow render_to_string(partial: "/dives/map_box", locals: { dive: dive })
    end
  end

end
