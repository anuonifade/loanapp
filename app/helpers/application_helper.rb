module ApplicationHelper

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

  def admin?
    user_role = User.find(@user_id)
    return true if user_role.role_id < 3
    false
  end

  def flash_class(level)
    case level
      when "notice" then "alert alert-info"
      when "success" then "alert alert-success"
      when "error" then "alert alert-danger"
      when "alert" then "alert alert-warning"
    end
  end
end
