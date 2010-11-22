module HelperMethods
  def create_and_preview_a_job!
    job = Factory.create :job
  
    visit preview_job job.id
  
    job
  end

  def create_and_edit_a_job!
    job = Factory.create :job

    visit edit_job job.id

    job
  end

  def publish_a_job
    job = Factory.create :job
    job.publish!
    job
  end
end
