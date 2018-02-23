class SourcesController < ApplicationController
  before_action :set_source, only: [:show]
  before_action :set_sources, only: [:index]

  def index
  end

  def show
  end

  private

  def set_source
    @source = Source.find(params[:id])
  end
end
