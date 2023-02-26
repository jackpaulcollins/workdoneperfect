# frozen_string_literal: true

class DashboardController < ApplicationController
  def show
    render controller: 'CalendarsController', action: 'show'
  end
end
