class UsersController < ApplicationController
  
  before_filter :require_login, :except => [:show, :new, :create]
  
  def index  
    @users = User.all
    respond_to do |format|
      format.html
    end
  end
  
  def show
    @user = User.find(params[:id])
    @activities = @user.activities.order('created_at DESC')
    @lists = @user.lists.order('created_at DESC')

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following #.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers #.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def lists
      @lists = List.find(:all, :conditions => ['user_id=?', current_user.id], :order => 'updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lists }
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
      redirect_to '/login', :notice => "Signed up!"
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
