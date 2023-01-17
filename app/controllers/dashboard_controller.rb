# frozen_string_literal: true

class DashboardController < ApplicationController
  include Pundit

  def show
    date_and_time = params.fetch(:start_date, Date.today).to_date
    @jobs = policy_scope(Job.where(date_and_time: date_and_time.beginning_of_month.beginning_of_week..date_and_time.end_of_month.end_of_week))
    authorize(Job, :index?)
  end
end
