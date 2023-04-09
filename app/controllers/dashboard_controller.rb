# frozen_string_literal: true

class DashboardController < ApplicationController
  def show
    render controller: "CalendarsController", action: "show"
  end

  def daily_data
    respond_to do |format|
      format.json { render json: {projected_revenue: projected_revenue, job_count: job_count, captured_revenue: captured_revenue} }
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
    jobs_in_range.sum(&:projected_revenue).round
  end

  def jobs_in_range
    Job.includes(:job_template).by_date_range(date_range)
  end

  def job_count
    jobs_in_range.count
  end

  def captured_revenue
    jobs_in_range.sum(:revenue).round
  end
end
