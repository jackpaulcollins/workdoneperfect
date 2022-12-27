# frozen_string_literal: true

json.array! @company_resources, partial: "company_resources/company_resource", as: :resource
