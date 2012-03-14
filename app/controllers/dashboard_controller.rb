class DashboardController < ApplicationController
    
  def index      
    # terrible fix, to be strictly temporary
    if current_user
      @lists = List.all(:limit => 5)
      @user_lists = List.find(:all, :conditions => ['user_id=?', current_user.id], :order => 'created_at DESC')
            
      @feed_items = current_user.feed.order('created_at DESC')
      
      @users = User.order('neurons DESC').limit(4)
      
      template = 'dashboard/index'
    else
      @user = User.new
      template = 'home/index'
    end
        
    respond_to do |format|
      format.html { render :template => template }
      format.json { render :json => @facts }
    end
  end
  
end
