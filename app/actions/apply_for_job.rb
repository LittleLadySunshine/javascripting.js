class ApplyForJob
  def self.call(application, application_params)
    ApplyForJob.new(application, application_params).run!
  end

  def initialize(application, application_params)
    @application = application
    @application_params = application_params
  end

  def run!
    @application.update!(@application_params.merge(:status => Application.statuses[:applied]))
  end
end
