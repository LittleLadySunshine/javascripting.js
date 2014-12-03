class ClassProjectFeaturesController < InstructorRequiredController

  before_action do
    @class_project = ClassProject.find(params[:class_project_id])
  end

  def index
    @class_project_features = @class_project.features.ordered
  end

  include Reorderable
  def reorder
    update_positions ClassProjectFeature.ordered.where(class_project_id: @class_project)
  end

  def new
    @class_project_feature = ClassProjectFeature.new
  end

  def create
    @class_project_feature = ClassProjectFeature.new(class_project_feature_params)
    @class_project_feature.class_project = @class_project

    if @class_project_feature.save
      redirect_to(
        class_project_feature_path(@class_project, @class_project_feature),
        notice: 'Project Feature was added successfully'
      )
    else
      render :new
    end
  end

  def show
    @class_project_feature = @class_project.features.find(params[:id])
  end

  def edit
    @class_project_feature = @class_project.features.find(params[:id])
  end

  def update
    @class_project_feature = @class_project.features.find(params[:id])

    if @class_project_feature.update(class_project_feature_params)
      redirect_to(
        class_project_feature_path(@class_project, @class_project_feature),
        notice: 'Project Feature was updated successfully'
      )
    else
      render :edit
    end
  end

  def destroy
    @class_project_feature = @class_project.features.find_by(id: params[:id])
    @class_project_feature.try(:destroy)
    redirect_to(
      class_project_features_path(@class_project),
      notice: 'Project Feature removed successfully'
    )
  end

  private

  def class_project_feature_params
    params.require(:class_project_feature).permit(
      :class_project_id,
      :name,
      :category,
      :stories,
      :wireframes,
      :position,
    )
  end
end