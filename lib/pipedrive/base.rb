module Pipedrive
  class Base
    def initialize(api_token = ::Pipedrive.api_token)
      fail 'api_token should be set' unless api_token.present?
      @api_token = api_token
    end

    def connection
      self.class.connection.dup
    end

    def make_api_call(*args)
      params = args.extract_options!
      method = args[0]
      fail 'method param missing' unless method.present?
      url = build_url(args, params.delete(:fields_to_select))
      res = connection.__send__(method.to_sym, url, params)
      process_response(res)
    end

    def build_url(args, fields_to_select = nil)
      url = "/v1/#{entity_name}"
      url << "/#{args[1]}" if args[1]
      if fields_to_select.is_a?(::Array) && fields_to_select.size > 0
        url << ":(#{fields_to_select.join(',')})"
      end
      url << "?api_token=#{@api_token}"
      url
    end

    def process_response(res)
      if res.success?
        data = if res.body.is_a?(::Hashie::Mash)
                 res.body.merge(success: true)
               else
                 ::Hashie::Mash.new(success: true)
               end
        return data
      end
      failed_response(res)
    end

    def failed_response(res)
      failed_res = res.body.merge(success: false, not_authorized: false,
                                  failed: false)
      case res.status
      when 401
        failed_res.merge! not_authorized: true
      when 420
        failed_res.merge! failed: true
      end
      failed_res
    end

    def entity_name
      class_name = self.class.name.split("::")[-1].downcase.pluralize
      class_names = { "people" => "persons" }
      class_names[class_name] || class_name
    end

    class << self
      def faraday_options
        {
          url:     'https://api.pipedrive.com',
          headers: {
            accept:     'application/json',
            user_agent: ::Pipedrive.user_agent
          }
        }
      end

      # This method smells of :reek:TooManyStatements
      def connection # :nodoc
        @connection ||= Faraday.new(faraday_options) do |conn|
          conn.request :url_encoded
          conn.response :mashify
          conn.response :json, content_type: /\bjson$/
          conn.use FaradayMiddleware::ParseJson
          conn.response :logger, ::Pipedrive.logger if ::Pipedrive.debug
          conn.adapter Faraday.default_adapter
        end
      end
    end
  end
end
