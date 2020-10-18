# frozen_string_literal: true

require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(SimpleCov::Formatter::HTMLFormatter)
SimpleCov.start do
  add_filter 'spec'
  minimum_coverage(76)
end
require 'webmock'
require 'webmock/rspec'
require 'pipedrive'

RSpec.configure do |config|
end
