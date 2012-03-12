class HomeController < ApplicationController

  def index
     
    @user = User.new
  
    respond_to do |format|
      format.html
    end
  end

end
