module Pipedrive
  module Operations
    module Update
      extend ActiveSupport::Concern

      def update(*args)
        params = args.extract_options!
        id = params.delete(:id) || args[0]
        fail 'id must be provided' unless id
        make_api_call(:put, id, params)
      end
    end
  end
end
