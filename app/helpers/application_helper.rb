module ApplicationHelper
  def nav_item(name, path, link_options: {})
    content_tag('li', :class => (current_page?(path) ? 'active' : nil)) do
      link_to(name, path, link_options)
    end
  end
end
