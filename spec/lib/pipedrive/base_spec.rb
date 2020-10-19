# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::Pipedrive::Base do
  subject { described_class.new('token') }

  describe '#entity_name' do
    subject { super().entity_name }

    it { is_expected.to eq described_class.name.split('::')[-1].downcase.pluralize }
  end

  context '::faraday_options' do
    subject { described_class.faraday_options }

    it {
      expect(subject).to eq({
        url:     'https://api.pipedrive.com',
        headers: { accept: 'application/json', content_type: "application/json", user_agent: 'Pipedrive Ruby Client v0.3.0' }
        })
      }
    end

  context '::connection' do
    subject { super().connection }

    it { is_expected.to be_kind_of(::Faraday::Connection) }
  end

  describe '#failed_response' do
    subject { super().failed_response(res) }

    let(:res) { double('res', body: ::Hashie::Mash.new({}), status: status) }

    context 'status is 401' do
      let(:status) { 401 }

      it {
        expect(subject).to eq(::Hashie::Mash.new({
                                                   failed:         false,
                                                  not_authorized: true,
                                                  success:        false
                                                 }))
      }
    end

    context 'status is 420' do
      let(:status) { 420 }

      it {
        expect(subject).to eq(::Hashie::Mash.new({
                                                   failed:         true,
                                                  not_authorized: false,
                                                  success:        false
                                                 }))
      }
    end

    context 'status is 400' do
      let(:status) { 400 }

      it {
        expect(subject).to eq(::Hashie::Mash.new({
                                                   failed:         false,
                                                  not_authorized: false,
                                                  success:        false
                                                 }))
      }
    end
  end

  describe '#make_api_call' do
    it 'faileds no method' do
      expect { subject.make_api_call(test: 'foo') }.to raise_error('method param missing')
    end

    context 'without id' do
      it 'calls :get' do
        stub_request(:get, 'https://api.pipedrive.com/v1/bases?api_token=token').to_return(status: 200, body: {}.to_json, headers: {})
        expect_any_instance_of(::Faraday::Connection).to receive(:get).with('/v1/bases?api_token=token', {}).and_call_original
        expect(subject.make_api_call(:get))
      end

      it 'calls :post' do
        stub_request(:post, 'https://api.pipedrive.com/v1/bases?api_token=token').to_return(status: 200, body: {}.to_json, headers: {})
        expect_any_instance_of(::Faraday::Connection).to receive(:post).with('/v1/bases?api_token=token', { test: 'bar' }.to_json).and_call_original
        expect(subject.make_api_call(:post, test: 'bar'))
      end

      it 'calls :put' do
        stub_request(:put, 'https://api.pipedrive.com/v1/bases?api_token=token').to_return(status: 200, body: {}.to_json, headers: {})
        expect_any_instance_of(::Faraday::Connection).to receive(:put).with('/v1/bases?api_token=token', { test: 'bar' }.to_json).and_call_original
        expect(subject.make_api_call(:put, test: 'bar'))
      end

      it 'uses field_selector properly' do
        stub_request(:get, 'https://api.pipedrive.com/v1/bases:(a,b,c)?api_token=token').to_return(status: 200, body: {}.to_json, headers: {})
        expect_any_instance_of(::Faraday::Connection).to receive(:get)
          .with('/v1/bases:(a,b,c)?api_token=token', {}).and_call_original
        expect(subject.make_api_call(:get, fields_to_select: %w[a b c]))
      end

      it 'does not use field_selector if it empty' do
        stub_request(:get, 'https://api.pipedrive.com/v1/bases?api_token=token').to_return(status: 200, body: {}.to_json, headers: {})
        expect_any_instance_of(::Faraday::Connection).to receive(:get)
          .with('/v1/bases?api_token=token', {}).and_call_original
        expect(subject.make_api_call(:get, fields_to_select: []))
      end

      it 'retries if Errno::ETIMEDOUT' do
        stub_request(:get, 'https://api.pipedrive.com/v1/bases?api_token=token').to_return(status: 200, body: {}.to_json, headers: {})
        connection = subject.connection
        allow(subject).to receive(:connection).and_return(connection)
        allow(connection).to receive(:get)
          .with('/v1/bases?api_token=token', {}).and_raise(Errno::ETIMEDOUT)
        expect(connection).to receive(:get)
          .with('/v1/bases?api_token=token', {}).and_call_original
        expect(subject.make_api_call(:get, fields_to_select: []))
      end
    end

    context 'with id' do
      it 'calls :get' do
        stub_request(:get, 'https://api.pipedrive.com/v1/bases/12?api_token=token').to_return(status: 200, body: {}.to_json, headers: {})
        expect_any_instance_of(::Faraday::Connection).to receive(:get).with('/v1/bases/12?api_token=token', {}).and_call_original
        expect(subject.make_api_call(:get, 12))
      end

      it 'calls :post' do
        stub_request(:post, 'https://api.pipedrive.com/v1/bases/13?api_token=token').to_return(status: 200, body: {}.to_json, headers: {})
        expect_any_instance_of(::Faraday::Connection).to receive(:post).with('/v1/bases/13?api_token=token', { test: 'bar' }.to_json).and_call_original
        expect(subject.make_api_call(:post, 13, test: 'bar'))
      end

      it 'calls :put' do
        stub_request(:put, 'https://api.pipedrive.com/v1/bases/14?api_token=token').to_return(status: 200, body: {}.to_json, headers: {})
        expect_any_instance_of(::Faraday::Connection).to receive(:put).with('/v1/bases/14?api_token=token', { test: 'bar' }.to_json).and_call_original
        expect(subject.make_api_call(:put, 14, test: 'bar'))
      end
    end

    it 'calls Hashie::Mash if return empty string' do
      stub_request(:get, 'https://api.pipedrive.com/v1/bases?api_token=token').to_return(status: 200, body: '', headers: {})
      expect(::Hashie::Mash).to receive(:new).with(success: true).and_call_original
      expect(subject.make_api_call(:get))
    end

    it 'calls #failed_response if failed status' do
      stub_request(:get, 'https://api.pipedrive.com/v1/bases?api_token=token').to_return(status: 400, body: '', headers: {})
      expect(subject).to receive(:failed_response)
      expect(subject.make_api_call(:get))
    end
  end
end
