class ListsController < ApplicationController
  
  before_filter :require_login 
    
  # GET /lists
  # GET /lists.json
  def index
    @lists = List.find(:all, :order => 'created_at DESC')
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lists }
    end
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    @list = List.find(params[:id])
    @facts = Fact.find(:all, :joins => [:lists, :listizations], :conditions => ['lists.id=?', @list.id], :order => 'listizations.position')
    @fact = Fact.new
     
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @list }
    end
  end

  # GET /lists/new
  # GET /lists/new.json
  def new
    @list = List.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @list }
    end
  end

  # GET /lists/1/edit
  def edit
    @list = List.find(params[:id])
  end

  # POST /lists
  # POST /lists.json
  def create
    @list = List.new(params[:list]) 
    
    current_user.lists << @list
    
    activity = current_user.activities.create
    activity.verb = 'created the list'
    activity.list = @list
    activity.save

    respond_to do |format|
      if @list.save
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render json: @list, status: :created, location: @list }
      else
        format.html { render action: "new" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lists/1
  # PUT /lists/1.json
  def update
    @list = List.find(params[:id])

    respond_to do |format|
      if @list.update_attributes(params[:list])
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list = List.find(params[:id])
    @list.destroy

    respond_to do |format|
      format.html { redirect_to lists_url }
      format.json { head :ok }
    end
  end
  
  def removeFact
    @list = List.find(params[:list_id])
    @fact = Fact.find(params[:fact_id])
    @list.facts.delete(@fact)
    
    redirect_to @list
  end
  
  def sort
    params[:fact].each_with_index do |id, index|
      Listization.update_all({position: index+1}, {fact_id: id})
    end
    render nothing: true
  end  
  
end
