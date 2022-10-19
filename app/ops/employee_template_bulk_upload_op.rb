require "subroutine/association_fields"
require "smarter_csv"

class EmployeeTemplateBulkUploadOp < ::Subroutine::Op
  include ::Subroutine::AssociationFields

  file :data
  string :title
  association :account

  outputs :success
  outputs :failures

  protected

  def perform
    hash = extract_csv
    create_resources(hash)
  end

  def extract_csv
    File.open(data, "r:bom|utf-8") do |f|
      data = SmarterCSV.process(f)
    end
  end

  def create_resources(hash)
    successes = []
    failures = []

    hash.each_with_index do |row, index|
      t = EmployeeTemplate.new(
        account: account,
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
        failures << "row #{index + 1} :#{t.errors.full_messages.to_s.delete("[").delete("]").delete('"')}"
      end
    end

    return save_records(successes) if failures.empty?

    output :failures, failures
    output :success, false
  end

  def save_records(records)
    records.each(&:save!)
    output :success, true
    output :failures, false
  end
end
