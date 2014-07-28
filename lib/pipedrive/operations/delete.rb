module Pipedrive
  module Operations
    module Delete
      extend ActiveSupport::Concern

      def delete(id)
        make_api_call({ method: :delete, url: entity_name, id: id }, {})
      end

      def delete_all
        make_api_call({ method: :delete, url: entity_name }, {})
      end
    end
  end
end
