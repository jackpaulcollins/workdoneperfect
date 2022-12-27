# frozen_string_literal: true

json.array! @employee_templates, partial: "employee_templates/employee_template", as: :employee_template
