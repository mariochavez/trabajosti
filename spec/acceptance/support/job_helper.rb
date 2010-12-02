module HelperMethods
  def create_and_preview_a_job!
    job = Factory.create :job
  
    visit preview_job job.id, job.token
  
    job
  end

  def create_and_edit_a_job!
    job = Factory.create :job

    visit edit_job job.id, job.token 

    job
  end

  def publish_a_job
    job = Factory.create :job
    job.publish!
    job
  end

  def create_and_publish_40_jobs!
    40.times do
      job = Factory.create :job
      job.publish!
    end
  end

  def create_40_jobs!
    40.times do
      job = Factory.create :job
    end
  end
end
