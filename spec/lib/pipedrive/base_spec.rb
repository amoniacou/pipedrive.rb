require 'spec_helper'

RSpec.describe ::Pipedrive::Base do
  subject { described_class.new('token') }
  context '#entity_name' do
    subject { super().entity_name }
    it { is_expected.to eq described_class.name.split('::')[-1].downcase.pluralize }
  end

  context '::faraday_options' do
    subject { described_class.faraday_options }
    it { is_expected.to eq({
      url:     'https://api.pipedrive.com',
      headers: { accept: 'application/json', user_agent: 'Pipedrive Ruby Client v0.0.1' }
    }) }
  end

  context '::connection' do
    subject { super().connection }
    it { is_expected.to be_kind_of(::Faraday::Connection) }
  end

  context '#failed_response' do
    let(:res) { double('res', body: ::Hashie::Mash.new({}), status: status) }
    subject { super().failed_response(res) }
    context 'status is 401' do
      let(:status) { 401 }
      it { is_expected.to eq(::Hashie::Mash.new({
                                                  failed:         false,
                                                  not_authorized: true,
                                                  success:        false
                                                })) }
    end
    context 'status is 420' do
      let(:status) { 420 }
      it { is_expected.to eq(::Hashie::Mash.new({
                                                  failed:         true,
                                                  not_authorized: false,
                                                  success:        false
                                                })) }
    end
    context 'status is 400' do
      let(:status) { 400 }
      it { is_expected.to eq(::Hashie::Mash.new({
                                                  failed:         false,
                                                  not_authorized: false,
                                                  success:        false
                                                })) }
    end
  end
  context '#make_api_call' do
    it 'should failed no method' do
      expect { subject.make_api_call(test: 'foo') }.to raise_error('method param missing')
    end
    context 'without id' do
      it 'should call :get' do
        stub_request(:get, 'https://api.pipedrive.com/v1/bases?api_token=token').to_return(:status => 200, :body => {}, :headers => {})
        expect_any_instance_of(::Faraday::Connection).to receive(:get).with('/v1/bases?api_token=token', {}).and_call_original
        expect(subject.make_api_call(:get))
      end
      it 'should call :post' do
        stub_request(:post, 'https://api.pipedrive.com/v1/bases?api_token=token').to_return(:status => 200, :body => {}, :headers => {})
        expect_any_instance_of(::Faraday::Connection).to receive(:post).with('/v1/bases?api_token=token', { test: 'bar' }).and_call_original
        expect(subject.make_api_call(:post, test: 'bar'))
      end
      it 'should call :put' do
        stub_request(:put, 'https://api.pipedrive.com/v1/bases?api_token=token').to_return(:status => 200, :body => {}, :headers => {})
        expect_any_instance_of(::Faraday::Connection).to receive(:put).with('/v1/bases?api_token=token', { test: 'bar' }).and_call_original
        expect(subject.make_api_call(:put, test: 'bar'))
      end
      it 'should use field_selector properly' do
        stub_request(:get, 'https://api.pipedrive.com/v1/bases:(a,b,c)?api_token=token').to_return(:status => 200, :body => {}, :headers => {})
        expect_any_instance_of(::Faraday::Connection).to receive(:get).
          with('/v1/bases:(a,b,c)?api_token=token', {}).and_call_original
        expect(subject.make_api_call(:get, fields_to_select: %w(a b c)))
      end
      it 'should not use field_selector if it empty' do
        stub_request(:get, 'https://api.pipedrive.com/v1/bases?api_token=token').to_return(:status => 200, :body => {}, :headers => {})
        expect_any_instance_of(::Faraday::Connection).to receive(:get).
          with('/v1/bases?api_token=token', {}).and_call_original
        expect(subject.make_api_call(:get, fields_to_select: []))
      end
      it 'should retry if Errno::ETIMEDOUT' do
        stub_request(:get, 'https://api.pipedrive.com/v1/bases?api_token=token').to_return(:status => 200, :body => {}, :headers => {})
        connection = subject.connection
        allow(subject).to receive(:connection).and_return(connection)
        allow(connection).to receive(:get).
          with('/v1/bases?api_token=token', {}).and_raise(Errno::ETIMEDOUT)
        expect(connection).to receive(:get).
          with('/v1/bases?api_token=token', {}).and_call_original
        expect(subject.make_api_call(:get, fields_to_select: []))
      end
    end
    context 'with id' do
      it 'should call :get' do
        stub_request(:get, 'https://api.pipedrive.com/v1/bases/12?api_token=token').to_return(:status => 200, :body => {}, :headers => {})
        expect_any_instance_of(::Faraday::Connection).to receive(:get).with('/v1/bases/12?api_token=token', {}).and_call_original
        expect(subject.make_api_call(:get, 12))
      end
      it 'should call :post' do
        stub_request(:post, 'https://api.pipedrive.com/v1/bases/13?api_token=token').to_return(:status => 200, :body => {}, :headers => {})
        expect_any_instance_of(::Faraday::Connection).to receive(:post).with('/v1/bases/13?api_token=token', { test: 'bar' }).and_call_original
        expect(subject.make_api_call(:post, 13, test: 'bar'))
      end
      it 'should call :put' do
        stub_request(:put, 'https://api.pipedrive.com/v1/bases/14?api_token=token').to_return(:status => 200, :body => {}, :headers => {})
        expect_any_instance_of(::Faraday::Connection).to receive(:put).with('/v1/bases/14?api_token=token', { test: 'bar' }).and_call_original
        expect(subject.make_api_call(:put, 14, test: 'bar'))
      end
    end
    it 'should call Hashie::Mash if return empty string' do
      stub_request(:get, 'https://api.pipedrive.com/v1/bases?api_token=token').to_return(:status => 200, :body => '', :headers => {})
      expect(::Hashie::Mash).to receive(:new).with(success: true).and_call_original
      expect(subject.make_api_call(:get))
    end
    it 'should call #failed_response if failed status' do
      stub_request(:get, 'https://api.pipedrive.com/v1/bases?api_token=token').to_return(:status => 400, :body => '', :headers => {})
      expect(subject).to receive(:failed_response)
      expect(subject.make_api_call(:get))
    end
  end
end