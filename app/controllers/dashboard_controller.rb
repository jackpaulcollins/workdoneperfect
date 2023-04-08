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
    if params[:start].present? && params[:end].present?
      start_date = Date.parse(params[:start])
      end_date = Date.parse(params[:end])
    else
      start_date = Date.today
      end_date = Date.today
    end
  
    [start_date, end_date]
  end

  def projected_revenue
    jobs = Job.includes(:job_template).by_date_range(date_range)
    jobs.sum { |job| job.estimated_hours * job.job_template.hourly_rate }.round
  end
end
