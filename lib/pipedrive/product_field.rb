# frozen_string_literal: true

module Pipedrive
  class ProductField < Base
    include ::Pipedrive::Operations::Read
    include ::Pipedrive::Operations::Create
    include ::Pipedrive::Operations::Delete

    def entity_name
      'productFields'
    end
  end
end
