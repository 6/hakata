class VotesController < ApplicationController

  # POST /votes
  def create
    @vote = Vote.new(params[:vote]) 
    @fact = Fact.find(params[:fact_id])

    respond_to do |format|
      if @vote.save
        format.html { redirect_to @fact, notice: 'vote was successfully created.' }
        format.json { render json: @fact, status: :created, location: @fact }
      else
        format.html { render action: "new" }
        format.json { render json: @fact.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /votes/1
  def destroy
    @vote = Vote.find(params[:id])
    @vote.destroy
    render nothing: true
  end

end
