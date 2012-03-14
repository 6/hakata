class VotesController < ApplicationController
  
  # POST /votes
  def create
    @mnemonic = Mnemonic.find(params[:mnemonic_id])
    @vote = Vote.new(params[:vote])
    @vote.up = params[:up]
    @mnemonic.votes << @vote
    current_user.votes << @vote
    @vote.save
    
    if @vote.up
      @mnemonic.user.neurons += 1
      @mnemonic.user.save
    end
    
    render :json => @vote
  end

  
  # DELETE /votes/1
  def destroy
    @vote = Vote.find(params[:id])
    @mnemonic = Mnemonic.find(@vote.mnemonic_id)
    
    if @vote.up
      @mnemonic.user.neurons = @mnemonic.user.neurons - 1
      @mnemonic.user.save
    end
    
    @vote.destroy
    render nothing: true
  end

end
