# frozen_string_literal: true

class CalendarsController < ApplicationController
  def show
    jobs = Job.by_date_range(date_range).includes(:company_resources).map do |job|
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

  private

  def parse_range
  end

  def date_range
    puts params[:dates]
    puts "*" * 100
  end
end
