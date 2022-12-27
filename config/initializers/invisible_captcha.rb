# frozen_string_literal: true

InvisibleCaptcha.setup do |config|
  config.timestamp_enabled = !Rails.env.test?

  config.honeypots = ["honeypotx"] if Rails.env.test?
end
