# frozen_string_literal: true

class AnnouncementsController < ApplicationController
  before_action :mark_as_read, if: :user_signed_in?

  def index
    @pagy, @announcements = pagy(Announcement.order(published_at: :desc))
  end

  def show
    @announcement = Announcement.find(params[:id])
  end

  private

  def mark_as_read
    current_user.update(announcements_read_at: Time.zone.now)
  end
end
