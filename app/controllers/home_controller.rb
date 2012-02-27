class HomeController < ApplicationController

  before_filter :require_login

  def index
    @lists = List.all(:limit => 5)
    @user_lists = List.find(:all, :conditions => ['user_id=?', current_user.id], :order => 'created_at DESC')
    @activities = Activity.all(:order => 'created_at DESC')
    
    respond_to do |format|
      format.html
      format.json { render :json => @facts }
    end
  end
end
