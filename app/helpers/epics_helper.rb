module EpicsHelper

  def epic_markdown(epic)
    string = "### gCamp Stories: #{epic.name}".html_safe
    string << "\n\n```\n"
    string << epic.stories
    string << "\n```\n\n"
    string << epic.wireframes
    string
  end

end
