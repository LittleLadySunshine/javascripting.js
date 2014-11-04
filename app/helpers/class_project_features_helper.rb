module ClassProjectFeaturesHelper

  def class_project_feature_markdown(class_project_feature)
    string = "### gCamp Stories: #{@class_project_feature.name}".html_safe
    string << "\n\n```\n"
    string << @class_project_feature.stories
    string << "\n```\n\n"
    string << @class_project_feature.wireframes
    string
  end

end
