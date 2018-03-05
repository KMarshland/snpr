class DiseasesController < ApplicationController
  before_action :set_disease

  def show
  end

  private

  def set_disease
    @disease = Disease.find_by!(short_form: params[:short_form])
  end
end
