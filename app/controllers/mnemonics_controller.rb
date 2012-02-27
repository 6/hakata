class MnemonicsController < ApplicationController
  # GET /mnemonics
  # GET /mnemonics.json
  def index
    @mnemonics = Mnemonic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @mnemonics }
    end
  end

  # GET /mnemonics/1
  # GET /mnemonics/1.json
  def show
    @mnemonic = Mnemonic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @mnemonic }
    end
  end

  # GET /mnemonics/new
  # GET /mnemonics/new.json
  def new
    @mnemonic = Mnemonic.new
    
#     user.mnemonics << mnemonic
#     @mnemonics.user << current_user

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @mnemonic }
    end
  end

  # GET /mnemonics/1/edit
  def edit
    @mnemonic = Mnemonic.find(params[:id])
  end

  # POST /mnemonics
  # POST /mnemonics.json
  def create
    @mnemonic = Mnemonic.new(params[:mnemonic])

    @fact = Fact.find(:first, :conditions => ['id=?', params[:mnemonic][:fact_id]])
    
    activity = current_user.activities.create
    activity.fact = @fact
    activity.mnemonic = @mnemonic
    if params[:list_id]
      @list = List.find_by_id(params[:list_id])
      activity.list = @list
    end
    activity.save
    
    @fact.mnemonics << @mnemonic

    respond_to do |format|
      if @mnemonic.save
        format.html { redirect_to @fact, :notice => 'Mnemonic was successfully created.' }
        format.json { render :json => @mnemonic, :status => :created, :location => @mnemonic }
      else
        format.html { render :action => "new" }
        format.json { render :json => @mnemonic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mnemonics/1
  # PUT /mnemonics/1.json
  def update
    @mnemonic = Mnemonic.find(params[:id])
    @fact = @mnemonic.fact
    
    if params[:mnemonic][:score]
      if params[:mnemonic][:score] == 'up'
        @vote = Vote.new
        @mnemonic.votes << @vote
        current_user.votes << @vote
        @vote.save
        @mnemonic.score = @mnemonic.score + 1
      else
        @vote = Vote.find(:first, :conditions => ['user_id=? AND mnemonic_id=?', current_user.id, @mnemonic.id])
        # take vote association off
        @mnemonic.score = @mnemonic.score - 1
      end
    end

    respond_to do |format|
      if @mnemonic.update_attributes(params[:mnemonic])
        format.html { redirect_to @fact, :notice => 'Mnemonic was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @mnemonic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mnemonics/1
  # DELETE /mnemonics/1.json
  def destroy
    @mnemonic = Mnemonic.find(params[:id])
    @mnemonic.destroy

    respond_to do |format|
      format.html { redirect_to mnemonics_url }
      format.json { head :ok }
    end
  end
end
