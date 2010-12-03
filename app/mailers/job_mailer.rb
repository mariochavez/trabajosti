class JobMailer < ActionMailer::Base
  default :from => "empleosti@decisionesinteligentes.com"

  def published job
    @job = job

    mail :to => job.email, :subject => "Empleos TI: #{job.title}"
  end
end
