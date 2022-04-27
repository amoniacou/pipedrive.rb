# frozen_string_literal: true

module Pipedrive
  class Deal < Base
    include ::Pipedrive::Operations::Create
    include ::Pipedrive::Operations::Read
    include ::Pipedrive::Operations::Update
    include ::Pipedrive::Operations::Delete

    def search(*args)
      params = args.extract_options!
      params[:term] ||= args[0]
      raise 'term is missing' unless params[:term]

      make_api_call(:get, 'search', params)
    end
  end
end
