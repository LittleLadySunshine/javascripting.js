module EpicsHelper

  def epic_markdown(epic)
    string = "### gCamp Stories: #{epic.name}".html_safe
    string << "\n\n```\n"
    string << ['Estimate', 'Current State', 'Labels', 'Title', 'Description'].to_csv
    epic.stories.each do |story|
      string << [1,'unstarted',[epic.label, epic.category].reject(&:blank?).join(", "), story.title, story.description].to_csv
    end
    string << "\n```\n\n"
    string << epic.wireframes
    string
  end

end
