# frozen_string_literal: true

module DefaultTemplateConcern
  extend ActiveSupport::Concern

  def default_template_present?
    JobTemplate.default_template.present?
  end
end
