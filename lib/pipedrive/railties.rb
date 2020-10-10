# frozen_string_literal: true

module Pipedrive
  class Railties < ::Rails::Railtie
    initializer 'Pipedrive logger' do
      ::Pipedrive.logger = ::Rails.logger
    end
  end
end
