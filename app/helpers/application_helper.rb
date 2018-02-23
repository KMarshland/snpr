module ApplicationHelper

  def menu_item(name, path, opts={})
    is_current = current_page? path

    "<li class=\"#{is_current ? 'active' : ''}\">#{block_given? ? yield : link_to(name, path, opts)}</li>".html_safe
  end

end
