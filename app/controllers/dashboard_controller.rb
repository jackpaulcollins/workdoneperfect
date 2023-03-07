# frozen_string_literal: true

class DashboardController < ApplicationController
  helper_method :date_range

  def show
    render controller: "CalendarsController", action: "show"
  end

  def daily_data
    respond_to do |format|
      format.html { render partial: "dashboard/daily_data", locals: {date_range: date_range} }
      format.json { render json: {data: params[:dates]} }
    end
  end

  def date_range
    params[:date] ||= Date.today
  end
end
