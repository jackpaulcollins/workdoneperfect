# frozen_string_literal: true

module Jumpstart
  class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true
  end
end
