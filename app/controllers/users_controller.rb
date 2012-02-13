class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @targets = Target.find(:all,
                           :joins => :mnemonics, 
                           :conditions => ["mnemonics.user_id=?", @user.id])
    @best = Target.find(:all,
                        :joins => :mnemonics,
                        :conditions => ["mnemonics.user_id=? AND mnemonics.best=?", @user.id, true])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

end
