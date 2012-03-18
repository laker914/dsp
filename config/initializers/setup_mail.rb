ActionMailer::Base.smtp_settings = {
  :address  => "smtp.gmail.com",
  :port => 587,
  :domain => "dsp.com",
  :user_name => "laker914@gmail.com",
  :password => "wdmcmc",
  :authentication => "plain",
  :enable_starttls_auto => true
}