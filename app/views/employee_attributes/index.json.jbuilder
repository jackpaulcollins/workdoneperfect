# frozen_string_literal: true

json.array! @employee_attributes, partial: "employee_attributes/employee_attribute", as: :employee_attribute
