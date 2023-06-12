# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Pipedrive do
  subject { described_class }

  before do
    described_class.reset!
  end

  describe '#reset!' do
    describe '#user_agent' do
      subject { super().user_agent }

      it { is_expected.to eq("Pipedrive Ruby Client v#{Pipedrive::VERSION}") }
    end

    describe '#api_token' do
      subject { super().api_token }

      it { is_expected.to be_nil }
    end

    describe '#logger' do
      subject { super().logger }

      it { is_expected.to be_a(Logger) }
    end
  end

  describe '#setup' do
    context 'single call' do
      let(:client) { described_class }

      it 'sets user_agent' do
        client.setup do |c|
          c.user_agent = 'Test1245'
        end
        expect(client.user_agent).to eq('Test1245')
      end

      it 'sets logger' do
        newlogger = Logger.new($stderr)
        client.setup do |c|
          c.logger = newlogger
        end
        expect(client.logger).to eq(newlogger)
      end

      it 'sets api_token' do
        client.setup do |c|
          c.api_token = 'test-api-key'
        end
        expect(client.api_token).to eq('test-api-key')
      end
    end

    context 'with double call' do
      let(:client) { described_class }

      it 'does not accept running setup more then once' do
        client.setup do |c|
          c.api_token = 'test-api-key'
        end
        client.setup do |c|
          c.api_token = 'test-api-key2'
        end
        expect(client.api_token).to eq('test-api-key')
      end
    end
  end
end
