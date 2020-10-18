# frozen_string_literal: true

module Pipedrive
  class PersonField < Base
    include ::Pipedrive::Operations::Read
    include ::Pipedrive::Operations::Create
    include ::Pipedrive::Operations::Update
    include ::Pipedrive::Operations::Delete

    def entity_name
      'personFields'
    end
  end
end
