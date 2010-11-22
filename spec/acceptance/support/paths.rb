module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def homepage
    "/"
  end

  def new_job
    "/jobs/new"
  end

  def preview_job(id)
    "/jobs/#{id}"
  end

  def edit_job(id)
    "/jobs/#{id}/edit"
  end

  def publish_job(id)
    "/jobs/#{id}/publish"
  end

  def edit_published_job(id, token)
    "/jobs/#{id}/edit/#{token}"
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
