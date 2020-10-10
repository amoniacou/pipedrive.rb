# frozen_string_literal: true

module Pipedrive
  module Operations
    module Update
      extend ActiveSupport::Concern

      def update(*args)
        params = args.extract_options!
        params.symbolize_keys!
        id = params.delete(:id) || args[0]
        raise 'id must be provided' unless id

        make_api_call(:put, id, params)
      end
    end
  end
end
