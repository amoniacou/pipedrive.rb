module Pipedrive
  module Operations
    module Create
      extend ActiveSupport::Concern

      def create(params)
        make_api_call({ method: :post, url: entity_name }, params)
      end
    end
  end
end
