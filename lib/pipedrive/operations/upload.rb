require 'open-uri'

module Pipedrive
  module Operations
    module Upload
      extend ActiveSupport::Concern

      def upload(file, mime_type, params = {})
        filename = ::File.basename(file)
        open(file) do |f|
          params = params.each_with_object({}) do |(key, val), h|
            h[key] = Faraday::ParamPart.new(val, nil, key)
          end
          params[:file] = Faraday::UploadIO.new(f, mime_type, filename)

          url = build_url([])
          response = self.class.file_upload_connection.post(url, params)
          process_response(response)
        end
      end

      class_methods do
        def file_upload_connection
          @file_upload_connection ||= Faraday.new(self.faraday_options) do |conn|
            conn.request :multipart
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
end
