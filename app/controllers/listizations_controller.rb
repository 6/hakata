class ListizationsController < ApplicationController
  def sort
    params[:fact].each_with_index do |id, index|
      Listization.update_all({position: index+1}, {fact_id: id})
    end
    render nothing: true
  end 
end
