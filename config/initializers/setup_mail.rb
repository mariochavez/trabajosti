ActionMailer::Base.smtp_settings = {
  :address  => 'smtp.gmail.com',
  :port     => 587,
  :domain   => 'decisionesinteligentes.com',
  :user_name => 'empleosti@decisionesinteligentes.com',
  :password   => '13213455',
  :autentication => 'plain',
  :enable_starttls_auto => true
}

ActionMailer::Base.default_url_options[:host] = "empleosti.decisionesinteligentes.com"
ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
