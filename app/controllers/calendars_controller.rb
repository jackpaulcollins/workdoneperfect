class CalendarsController < ApplicationController
  def show
    jobs = Job.includes(:company_resources).all.map do |job|
      resource = job.company_resources.last if job.company_resources.present?
      {
        id: job.id,
        resource: resource.present? ? {id: resource.id, name: resource.name} : {id: 0},
        title: job.customer.email,
        start: job.date_and_time.iso8601,
        end: job.end_hour.iso8601
      }
    end
    render json: jobs
  end
end
