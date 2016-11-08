module Pipedrive
  class Organization < Base
    include ::Pipedrive::Operations::Read
    include ::Pipedrive::Operations::Create
    include ::Pipedrive::Operations::Update
    include ::Pipedrive::Operations::Delete
    include ::Pipedrive::Utils

    def find_by_name(*args)
      params = args.extract_options!
      params[:term] ||= args[0]
      fail 'term is missing' unless params[:term]
      return to_enum(:find_by_name, params) unless block_given?
      follow_pagination(:make_api_call, [:get, 'find'], params) { |item| yield item }
    end
  end
end
