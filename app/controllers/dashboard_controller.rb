# frozen_string_literal: true

class DashboardController < ApplicationController
  def show
    render controller: "CalendarsController", action: "show"
  end

  def daily_data
    render json: {data: params[:dates]}
  end
end
