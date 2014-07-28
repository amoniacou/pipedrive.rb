module Pipedrive
  class Person < Base
    include ::Pipedrive::Operations::Read
    include ::Pipedrive::Operations::Create
    include ::Pipedrive::Operations::Update
    include ::Pipedrive::Operations::Delete

    def find_by_name(name, search_by_email = false, params = {})
      params.merge!(term: name, search_by_email: search_by_email ? 1 : 0)
      make_api_call({ method: :get, url: entity_name, id: id }, params)
    end
  end
end
