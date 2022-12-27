# frozen_string_literal: true

require 'subroutine/association_fields'
require 'smarter_csv'

class EmployeeTemplateBulkUploadOp < ::Subroutine::Op
  include ::Subroutine::AssociationFields

  file :data
  string :title
  association :account

  outputs :successes
  outputs :failures

  protected

  def perform
    hash = extract_csv
    create_resources(hash)
  end

  def extract_csv
    File.open(data, 'r:bom|utf-8') do |f|
      SmarterCSV.process(f)
    end
  end

  def create_resources(hash)
    successes = []
    failures = []

    hash.each_with_index do |row, _index|
      t = EmployeeTemplate.new(
        account:,
        title: row[:template_title]
      )

      t.employee_attributes.build(
        name: row[:name],
        data_type: row[:data_type],
        required: row[:required]
      )

      if t.valid?
        successes << t
      else
        failures << t.title
      end
    end

    return save_records(successes) if failures.empty?

    output :failures, failures.count
    output :successes, false
  end

  def save_records(records)
    records.each(&:save!)
    output :successes, records.count
    output :failures, false
  end
end
