class ParametersController < ApplicationController
  
  
  def sort
    params[:parameters].each_with_index do |id, index|
      Parameter.update_all(['position=?', index+1], ['id=?', id])
    end
    render :nothing => true
  end
    
  
  
end