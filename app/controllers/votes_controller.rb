class VotesController < ApplicationController
  
  # POST /votes
  def create
    @mnemonic = Mnemonic.find(params[:mnemonic_id])
    @vote = Vote.new(params[:vote])
    @vote.up = params[:up]
    @mnemonic.votes << @vote
    current_user.votes << @vote
    @vote.save
    render :json => @vote
  end

  
  # DELETE /votes/1
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
    render nothing: true
  end

end
