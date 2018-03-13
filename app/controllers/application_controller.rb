class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :is_admin?

  def set_sources
    @set_sources = true
  end

  def requires_admin
    redirect_to('/', alert: 'Admins only, sorry') unless is_admin?
  end

  def is_admin?
    current_user.present? && current_user.admin
  end

end
