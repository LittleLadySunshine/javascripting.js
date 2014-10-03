module ApplicationHelper
  def nav_item(name, path, link_options: {})
    content_tag('li', :class => (current_page?(path) ? 'active' : nil)) do
      link_to(name, path, link_options)
    end
  end

  def get_home_path
    if user_session.signed_in?
      if user_session.current_user.instructor?
        instructor_cohorts_path
      else
        cohort_exercises_path(user_session.current_user.cohort)
      end
    else
      root_path
    end
  end
end
