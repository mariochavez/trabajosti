module HelperMethods
  def self.create_and_publish_40_jobs!
    40.times do
      job = Factory.create :job
      job.publish!
    end
  end

  def self.create_40_jobs!
    40.times do
      job = Factory.create :job
    end
  end
end
