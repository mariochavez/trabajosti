module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def homepage
    "/"
  end

  def new_job
    "/jobs/new"
  end

  def preview_job(id, token)
    "/jobs/#{id}/#{token}"
  end

  def edit_job(id, token)
    "/jobs/#{id}/edit/#{token}"
  end

  def publish_job(id)
    "/jobs/#{id}/publish"
  end

  def all_job_offers
    "/all"
  end

  def show_offer(id)
    "/#{id}"
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
