# frozen_string_literal: true

module Pipedrive
  class LeadLabel < Base
    include ::Pipedrive::Operations::Create
    include ::Pipedrive::Operations::Read
    include ::Pipedrive::Operations::Update
    include ::Pipedrive::Operations::Delete

    def entity_name
      'leadLabels'
    end
  end
end
