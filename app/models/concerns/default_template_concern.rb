module DefaultTemplateConcern
  extend ActiveSupport::Concern

  def default_template_present?
    JobTemplate.default.present?
  end
end
