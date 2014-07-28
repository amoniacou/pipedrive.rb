module Pipedrive
  module Operations
    module Update
      extend ActiveSupport::Concern

      def update(id, params)
        make_api_call({ method: :put, url: entity_name, id: id }, params)
      end
    end
  end
end
