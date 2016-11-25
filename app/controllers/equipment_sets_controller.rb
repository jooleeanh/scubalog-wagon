class EquipmentSetsController < ApplicationController
  # before_action :find_user, only: [:create]
  before_action :find_equipment_set, only: [:update, :destroy]

  # If we want to use it
  def new
    @equipment_set = EquipmentSet.new
  end

  def create
    @user = current_user
    @equipment_set = @user.equipment_sets.new(equipment_set_params)
    if @equipment_set.save
      flash[:notice] = "Equipment set successfully created."
      redirect_to current_user
    else
      flash[:alert] = "Please review your equipment form for errors."
      render :new
    end
  end

  def update
    if @equipment_set.update(equipment_set_params)
      flash[:notice] = "Equipment set successfully updated."
      redirect_to current_user
    else
      flash[:alert] = "Please review your equipment form for errors."
      render :new
    end
  end

  def destroy
    @equipment_set.destroy
    redirect_to current_user
  end

  private

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_equipment_set
    @equipment_set = Equipmentset.find(params[:id])
  end

  def equipment_set_params
    params.require(:equipment_set).permit(:mask, :snorkel, :fins, :wetsuit, :computer, :bcd, :regulator, :weight)
  end
end
