class DiseasesController < ApplicationController
  before_action :set_disease, only: [:show]

  def show
  end

  def index
    @diseases = Disease.all

    render json: {diseases: @diseases.as_short_json}
  end

  private

  def set_disease
    @disease = Disease.find_by!(short_form: params[:short_form])
  end
end
