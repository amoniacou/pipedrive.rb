require 'spec_helper'

RSpec.describe ::Pipedrive do

  subject { described_class }

  before :each do
    described_class.reset!
  end

  context '#reset!' do
    describe '#user_agent' do
      subject { super().user_agent }
      it { is_expected.to eq("Pipedrive Ruby Client v#{::Pipedrive::VERSION}") }
    end

    describe '#api_token' do
      subject { super().api_token }
      it { is_expected.to be_nil }
    end

    describe '#logger' do
      subject { super().logger }
      it { is_expected.to be_kind_of(::Logger) }
    end
  end

  context '#setup' do
    context 'single call' do
      it 'should set user_agent' do
        subject.setup do |c|
          c.user_agent = 'Test1245'
        end
        expect(subject.user_agent).to eq('Test1245')
      end

      it 'should set logger' do
        newlogger = ::Logger.new(STDERR)
        subject.setup do |c|
          c.logger = newlogger
        end
        expect(subject.logger).to eq(newlogger)
      end

      it 'should set api_token' do
        subject.setup do |c|
          c.api_token = 'test-api-key'
        end
        expect(subject.api_token).to eq('test-api-key')
      end
    end

    context 'double call' do
      it 'should not accept running setup more then once' do
        subject.setup do |c|
          c.api_token = 'test-api-key'
        end
        subject.setup do |c|
          c.api_token = 'test-api-key2'
        end
        expect(subject.api_token).to eq('test-api-key')
      end
    end
  end
end