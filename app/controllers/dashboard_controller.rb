class DashboardController < ApplicationController
  def show
    @todays_schedule_items = ResourceSchedule.where(job_date: Date.today)
  end
end
