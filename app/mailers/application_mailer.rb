# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "admin@gmail.com"
  layout "mailer"
end
