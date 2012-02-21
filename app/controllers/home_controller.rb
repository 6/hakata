class HomeController < ApplicationController

  def index
    @lists = List.all(:limit => 5)
    
    respond_to do |format|
      format.html
      format.json { render :json => @facts }
    end
  end
end
