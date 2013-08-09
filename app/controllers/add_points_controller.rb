class AddPointsController < ApplicationController
  
  def index
    current_refinery_user.change_points({points: params[:points].to_i, type:  Type.where(name: params[:type]).first.id})
    render nothing: true
  end
end
