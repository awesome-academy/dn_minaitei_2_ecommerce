# frozen_string_literal: true

class AccountsMailer < Devise::Mailer
  helper :application
  default template_path: "account/mailer"
end
