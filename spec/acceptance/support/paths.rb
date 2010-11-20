module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def homepage
    "/"
  end

  def new_job
    "/jobs/new"
  end

  def preview_job
    '/jobs/preview'
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
