# frozen_string_literal: true

module Pipedrive
  module Operations
    module Delete
      extend ActiveSupport::Concern

      def delete(id)
        make_api_call(:delete, id)
      end

      def delete_all
        make_api_call(:delete)
      end
    end
  end
end
