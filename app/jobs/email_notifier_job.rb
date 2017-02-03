class EmailNotifierJob < ApplicationJob
  queue_as :default

  def perform(email, message, user_agent)
    LoginNotifierMailer.send_notifier_email(email, message, user_agent).deliver
  end
end
