# frozen_string_literal: true

class DashboardController < ApplicationController
  helper_method :date_range
  helper_method :projected_revenue

  def show
    render controller: "CalendarsController", action: "show"
  end

  def daily_data
    respond_to do |format|
      format.json { render json: {projected_revenue: projected_revenue} }
    end
  end

  def date_range
    params[:dates].present? ? Date.parse(params[:dates]) : Date.today
  end

  def projected_revenue
    jobs = Job.by_date_range([date_range..date_range])
    jobs.sum(&:estimated_hours) * 100
  end
end
