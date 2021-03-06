module ApplicationHelper
  def nav_item(name, path, link_options: {}, active: false)
    active ||= current_page?(path)
    content_tag('li', :class => (active ? 'active' : nil)) do
      link_to(name, path, link_options)
    end
  end

  def instructor_cohort_links(cohort)
    links = []

    instructor_link_groups(cohort).each do |key, value|
      if value.is_a?(Hash)
        value.each do |text, path|
          links << {text: text, path: path}
        end
      else
        links << {text: key, path: value}
      end
    end

    links.map{|hash| OpenStruct.new(hash) }
  end

  def instructor_link_groups(cohort)
    link_groups = {
      "Students" => {
        "Students" => instructor_cohort_path(cohort),
        "Action Plans" => instructor_cohort_action_plans_path(cohort),
        "Personal Projects" => instructor_cohort_projects_path(cohort),
        "Social Links" => social_instructor_cohort_path(cohort),
        "Assessments" => cohort_rubrics_path(cohort),
        "Mentors" => mentors_instructor_cohort_path(cohort),
      },
      "Daily Plans" => {
        "Today's Plan" => today_cohort_daily_plans_path(cohort),
        "All Plans" => cohort_daily_plans_path(cohort),
      },
      "Setup" => {
        "Staffings" => instructor_cohort_staffings_path(cohort),
        "Tracker Accounts" => instructor_cohort_tracker_accounts_path(cohort),
        "Import" => instructor_cohort_imports_path(cohort),
        "Writeup Topics" => instructor_cohort_writeup_topics_path(cohort),
        "Exercises" => instructor_cohort_cohort_exercises_path(cohort),
        "Greenhouse" => cohort_applications_path(cohort),
      },
      "Student Facing" => cohort_info_path(cohort),
      "1-on-1 Schedule" => one_on_ones_instructor_cohort_path(cohort),
      "Pairs" => instructor_cohort_pairs_path(cohort),
      "Edit" => edit_instructor_cohort_path(cohort),
    }
    ClassProject.all.each do |class_project|
      link_groups['Students']["#{class_project.name} Acceptance"] = acceptance_instructor_cohort_path(cohort, class_project_id: class_project.id)
    end
    if cohort.curriculum
      link_groups["Setup"] = {
        "Edit Curriculum" => instructor_curriculum_curriculum_units_path(cohort.curriculum)
      }.merge(link_groups["Setup"])
    end
    link_groups
  end

  def instructor_tab_renderers(cohort)
    instructor_link_groups(cohort).map do |key, value|
      if value.is_a?(Hash)
        LinkGroupRenderer.new(self, key, value)
      else
        LinkRenderer.new(self, key, value)
      end
    end
  end

  class LinkGroupRenderer
    attr_reader :view_context
    private :view_context
    delegate :content_tag, :link_to, to: :view_context

    def initialize(view_context, name, links)
      @view_context = view_context
      @name = name
      @links = links
    end

    def render
      content_tag :li, class: "dropdown" do
        link = link_to "#", data: {toggle: "dropdown"}, class: "dropdown-toggle" do
          @name.html_safe + content_tag(:span, nil, class: "caret")
        end

        list_items = @links.map do |text, path|
          content_tag :li, link_to(text, path)
        end

        link + content_tag(:ul, list_items.join.html_safe, class: "dropdown-menu", role: "menu")
      end
    end
  end

  class LinkRenderer
    attr_reader :view_context
    private :view_context
    delegate :nav_item, to: :view_context

    def initialize(view_context, text, path)
      @view_context = view_context
      @text = text
      @path = path
    end

    def render
      nav_item(@text, @path)
    end
  end

end
