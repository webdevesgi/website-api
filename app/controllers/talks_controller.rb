class TalksController < ApplicationController
  # GET /talks
  # GET /talks.json
  def index
    @talks = Talk.all

    render json: @talks
  end

  # GET /talks/1
  # GET /talks/1.json
  def show
    @talk = Talk.find(params[:id])

    render json: @talk
  end

  # POST /talks
  # POST /talks.json
  def create
    @talk = Talk.new(params[:talk])

    if @talk.save
      render json: @talk, status: :created, location: @talk
    else
      render json: @talk.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /talks/1
  # PATCH/PUT /talks/1.json
  def update
    @talk = Talk.find(params[:id])

    if @talk.update(params[:talk])
      head :no_content
    else
      render json: @talk.errors, status: :unprocessable_entity
    end
  end

  # DELETE /talks/1
  # DELETE /talks/1.json
  def destroy
    @talk = Talk.find(params[:id])
    @talk.destroy

    head :no_content
  end
end
