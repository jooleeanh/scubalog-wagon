class EquipmentSetsController < ApplicationController
  before_action :find_user, only: [:new, :create]
  before_action :find_equipment_set, only: [:update, :delete]

  # If we want to use it
  def new
    @equipment_set = EquipmentSet.new
  end

  def create
    @equipment_set = @user.equipment_sets.new(equipment_set_params)
    @equipment_set.save
    # TODO: if, redirect, render?
  end

  def update
    @equipment_set.update(equipment_set_params)
  end

  def destroy
    @equipment_set.destroy
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
