# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# Sendgrid config
ActionMailer::Base.smtp_settings = {
  :user_name => 'apikey',
  :password => ENV["SENGRID_KEY"],
  :domain => 'acid-test.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}