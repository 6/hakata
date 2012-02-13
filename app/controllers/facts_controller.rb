class FactsController < ApplicationController
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
    @lists = List.all
    @list = List.find(params[:list_id]) if params[:list_id]
    if @list  
      @listization = Listization.find(:first, :conditions => ['list_id = ? AND fact_id = ?', @list.id, @fact.id])
      @next = Fact.find(:first, :joins => :listizations, :conditions => ['listizations.id > ? AND listizations.list_id = ?', @listization.id, @list.id])
      @previous = Fact.find(:last, :joins => :listizations, :conditions => ['listizations.id < ? AND listizations.list_id = ?', @listization.id, @list.id])
    end
    
    # Determine Flashcard View
    session[:cardview] ||= 'off'
    
    # get all lists this mofo is a part of
    @member_lists = List.find(:all, :joins => :listizations, :conditions => ['listizations.fact_id = ?', @fact.id])
    
    @mnemonics = @fact.mnemonics.sort_by{ |obj| obj.score.to_i }.reverse
    
    if current_user
      @moukaita = Mnemonic.find(:first, :conditions => ['fact_id = ? AND user_id = ?', @fact.id, current_user.id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @fact }
    end
  end

  # GET /facts/new
  # GET /facts/new.json
  def new
    @fact = Fact.new
    
#     element = @fact.elements.build
#     element.type = 'alpha'
#     element.name = 'vocabulary' # will be dictated by criteria through fields
    
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
    params[:fact][:field_id] = params[:fact][:field_id].to_i # stupidity
    @fact = Fact.new(params[:fact])
    
    puts "DEBUG LIKE A MONKEY ==================="

    respond_to do |format|
      if @fact.save
        format.html { redirect_to @fact, :notice => 'fact was successfully created.' }
        format.json { render :json => @fact, :status => :created, :location => @fact }
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
end
