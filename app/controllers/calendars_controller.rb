class CalendarsController < ApplicationController
  def show
    jobs = Job.all.map do |job|
      {
        id: job.id,
        resourceId: 'a',
        title: job.customer.email,
        start: job.date_and_time.iso8601,
        end: (job.date_and_time + 8.hours).iso8601
      }
    end
    render json: jobs
  end
end
