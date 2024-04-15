# frozen_string_literal: true

class Admin::AdminController < ApplicationController
  include OrdersHelper

  before_action :authenticate_account!, :author_admin

  def author_admin
    return if current_account.admin?

    flash[:error] = t("http_error.forbidden")
    redirect_to("/403.html")
  end
end
