module Pipedrive
  module Operations
    module Read
      extend ActiveSupport::Concern
      include ::Enumerable
      include ::Pipedrive::Utils

      # This method smells of :reek:TooManyStatements but ignores them
      def each(params = {})
        return to_enum(:each, params) unless block_given?
        follow_pagination(:chunk, [], params) { |item| yield item }
      end

      def all(params = {})
        each(params).to_a
      end

      def chunk(params = {})
        res = make_api_call(:get, params)
        return [] unless res.success?
        res
      end

      def find_by_id(id)
        make_api_call(:get, id)
      end
    end
  end
end
