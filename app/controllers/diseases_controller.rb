class DiseasesController < ApplicationController
  before_action :set_disease, only: [:show]

  def show
  end

  def index
    data = Rails.cache.fetch("disease_index", expires_in: 24.hours) do
      diseases = Disease.all.eager_load(:snps)
      diseases.as_json({summarize: true})
    end

    render json: {diseases: data}
  end

  private

  def set_disease
    @disease = Disease.find_by!(short_form: params[:short_form])
  end
end
