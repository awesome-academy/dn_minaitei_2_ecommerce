# frozen_string_literal: true
# rubocop:disable all

class Accounts::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create
    super
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email address phone_number password password_confirmation])
  end

  def send_devise_notification(resource, notification, *args)
    AccountsMailer.send(notification, resource, *args).deliver_now
  end

  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end
end
