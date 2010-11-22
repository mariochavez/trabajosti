module JobsHelper
  def get_expiration_date(job)
    expire_date = job.created_at + (3600 * 24 * 30)
    expire_date.to_s(:short)
  end
end
