# frozen_string_literal: true

class DashboardController < ApplicationController
  def show
    date_and_time = params.fetch(:start_date, Date.today).to_date
    @jobs = Job.where(date_and_time: date_and_time.beginning_of_month.beginning_of_week..date_and_time.end_of_month.end_of_week)
  end
end
