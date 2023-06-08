# frozen_string_literal: true

module Pipedrive
  module Utils
    extend ActiveSupport::Concern

    def follow_pagination(method, args, params, &block)
      start = params[:start] || 0
      loop do
        res = __send__(method, *args, **params.merge(start: start))
        break if !res.try(:data) || !res.success?

        res.data.each(&block)
        break unless res.try(:additional_data).try(:pagination).try(:more_items_in_collection?)

        start = res.try(:additional_data).try(:pagination).try(:next_start)
      end
    end
  end
end
