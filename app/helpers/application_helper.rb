module ApplicationHelper

  def admin?
    
  end

  def navigation_menu(name, path, icon="calendar")
    class_name = "nav-link"
    if current_page?(path)
      class_name += " active" 
      path = "#"
    end
    "<li class='nav-item'>
      <a class='#{class_name}' href='#{path}'>
        <span class='fa fa-#{icon}'></span>
        #{name}
      </a>
    </li>".html_safe
  end
end
