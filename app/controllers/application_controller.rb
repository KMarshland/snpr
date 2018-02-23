class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def set_sources
    @set_sources = true
  end

end
