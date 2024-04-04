# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend
  include Constants

  def full_title(page_title = "")
    default_title = t("default_title")
    page_title.empty? ? default_title : "#{default_title} | #{page_title}"
  end

  def uppercase(string)
    string.upcase
  end

  def bootstrap_class_for(flash_type)
    case flash_type
    when Constants::SUCCESS
      "toast align-items-center text-white bg-success border-0"
    when Constants::DANGER && Constants::ERROR
      "toast align-items-center text-white bg-danger border-0"
    when Constants::ALERT
      "toast align-items-center text-white bg-primary border-0"
    when Constants::NOTICE
      "toast align-items-center text-white bg-info border-0"
    else
      flash_type.to_s
    end
  end
end
