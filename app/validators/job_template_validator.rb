class JobTemplateValidator < ActiveModel::Validator
  include DefaultTemplateConcern

  # this shouldn't happen because of the before_validation
  # but just in case

  def validate(record)
    if record.default_template && default_template_present?
      record.errors.add :base, "Default template is set"
    end
  end
end
