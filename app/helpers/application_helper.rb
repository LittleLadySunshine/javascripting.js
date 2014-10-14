module ApplicationHelper
  def nav_item(name, path, link_options: {})
    content_tag('li', :class => (current_page?(path) ? 'active' : nil)) do
      link_to(name, path, link_options)
    end
  end

  def instructor_cohort_links(cohort)
    [
      {text: "Students", path: instructor_cohort_path(cohort)},
      {text: "1-on-1 Schedule", path: one_on_ones_instructor_cohort_path(cohort)},
      {text: "Pairs", path: instructor_cohort_pairs_path(cohort)},
      {text: "Exercises", path: instructor_cohort_cohort_exercises_path(cohort)},
      {text: "Edit", path: edit_instructor_cohort_path(cohort)},
      {text: "Tracker Accounts", path: instructor_cohort_tracker_accounts_path(cohort)},
      {text: "Curriculum", path: cohort.curriculum_site_url},
      {text: "Staffings", path: instructor_cohort_staffings_path(cohort)},
      {text: "Import", path: instructor_cohort_imports_path(cohort)},
      {text: "Info", path: cohort_info_path(cohort)},
      {text: "Acceptance", path: acceptance_instructor_cohort_path(cohort)},
    ].map{|hash| OpenStruct.new(hash) }
  end
end
