class FactsController < ApplicationController

  before_filter :initialize_cardview

  # GET /facts
  # GET /facts.json
  def index
    @facts = Fact.order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @facts }
    end
  end

  # GET /facts/1
  # GET /facts/1.json
  def show
    @fact = Fact.find(params[:id])
    @mnemonic = Mnemonic.new
    @user_lists = List.find(:all, :conditions => ['user_id=?', current_user.id], :order => 'updated_at DESC')
    @list = List.find(params[:list_id]) if params[:list_id] 
    @listization = Listization.find(:first, :conditions => ['list_id = ? AND fact_id = ?', @list.id, @fact.id])
    @previous = @fact.previous_in_list(@list)
    @two_back = @fact.two_back_in(@list)
    @next = @fact.next_in_list(@list)
    @two_forward = @fact.two_forward_in(@list)
    
    # get all lists this mofo is a part of
    @member_lists = List.find(:all, :joins => :listizations, :conditions => ['listizations.fact_id = ?', @fact.id])
    
    @mnemonics = @fact.mnemonics.sort_by{ |m| m.votes.count }.reverse    
    
    if current_user
      @moukaita = Mnemonic.find(:first, :conditions => ['fact_id = ? AND user_id = ?', @fact.id, current_user.id])
    end
    
    @vote = Vote.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @fact }
    end
  end

  # GET /facts/new
  # GET /facts/new.json
  def new
    @fact = Fact.new
    if params[:list_id]
      @list_id = params[:list_id]
    end
    
    @lists = List.all
    @fields = Field.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @fact }
    end
  end

  # GET /facts/1/edit
  def edit
    @fact = Fact.find(params[:id])
  end

  # POST /facts
  # POST /facts.json
  def create
    @fact = Fact.new(params[:fact])
    
    if params[:list_id]
      @list = List.find(:first, :conditions => ['id=?', params[:list_id]])
      @list.facts << @fact
    end

    respond_to do |format|
      if @fact.save
        format.html { redirect_to @list, :notice => 'fact was successfully created.' }
        format.json { render :json => @list, :status => :created, :location => @list }
      else
        format.html { render :action => "new" }
        format.json { render :json => @fact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /facts/1
  # PUT /facts/1.json
  def update
    @fact = Fact.find(params[:id])
    
    if params[:add_fact_to_list]
      list = List.find(:first, :conditions => ['id=?', params[:add_fact_to_list]])
      @fact.lists << list
    end

    respond_to do |format|
      if @fact.update_attributes(params[:fact])
        format.html { redirect_to @fact, :notice => 'fact was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @fact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /facts/1
  # DELETE /facts/1.json
  def destroy
    @fact = Fact.find(params[:id])
    @fact.destroy

    respond_to do |format|
      format.html { redirect_to facts_url }
      format.json { head :ok }
    end
  end

  def set_key_bindings
    puts params[:key_bindings]
    if params[:key_bindings] == 'true'
      session[:key_bindings] = true
    elsif params[:key_bindings] == 'false'
      session[:key_bindings] = false
    end
    puts session[:key_bindings]
    render nothing: true
  end
  
  private
  
  def initialize_cardview
    # Determine Flashcard View
    if session[:cardview] != 'off' ||
       session[:cardview] != 'back' ||
       session[:cardview] != 'front'
       session[:cardview] = 'off'
    end
  end
  
end
