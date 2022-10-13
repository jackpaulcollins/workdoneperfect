require "subroutine/association_fields"

class MapEmployeeTemplateAttributes < ::Subroutine::Op
  include ::Subroutine::AssociationFields

  field :template_attributes

  def perform
    puts "IN THE OP" * 100, employee
  end
end
