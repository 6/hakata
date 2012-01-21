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

    @target = Target.find(:first, :conditions => ['id=?', params[:mnemonic][:target_id]])
    
    @target.mnemonics << @mnemonic

    respond_to do |format|
      if @mnemonic.save
        format.html { redirect_to @mnemonic, :notice => 'Mnemonic was successfully created.' }
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
    @target = @mnemonic.target

    respond_to do |format|
      if @mnemonic.update_attributes(params[:mnemonic])
        format.html { redirect_to @target, :notice => 'Mnemonic was successfully updated.' }
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
