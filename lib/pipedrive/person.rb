module Pipedrive
  class Person < Base
    include ::Pipedrive::Operations::Read
    include ::Pipedrive::Operations::Create
    include ::Pipedrive::Operations::Update
    include ::Pipedrive::Operations::Delete

    def find_by_name(*args)
      params = args.extract_options!
      fail 'term is missing' unless args[0]
      params.merge!(term: args[0])
      params.merge!(search_by_email: 1) if args[1]
      make_api_call(:get, params)
    end
  end
end
