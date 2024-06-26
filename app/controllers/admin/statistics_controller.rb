# frozen_string_literal: true

class Admin::StatisticsController < Admin::AdminController
  def monthly_statistics
    @statistics = Order.statistical_product
  end

  def monthly_statistics_detail
    @year = params[:year]
    @month = params[:month]
    @statistics_detail_sum = OrderHistory.statistical_detail_sum(year: @year, month: @month)
    @pagy, @statistics_detail = pagy(OrderHistory.statistical_detail(@year, @month), items: Settings.DIGIT_5)
  end
end
