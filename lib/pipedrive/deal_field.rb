# frozen_string_literal: true

module Pipedrive
  class DealField < Base
    include ::Pipedrive::Operations::Create
    include ::Pipedrive::Operations::Read
    include ::Pipedrive::Operations::Delete

    def entity_name
      'dealFields'
    end
  end
end
