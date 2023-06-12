# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Pipedrive::Operations::Update do
  subject do
    Class.new(Pipedrive::Base) do
      include Pipedrive::Operations::Update
    end.new('token')
  end

  describe '#create' do
    it 'calls #make_api_call' do
      expect(subject).to receive(:make_api_call).with(:put, 12, { foo: 'bar' })
      subject.update(12, foo: 'bar')
    end

    it 'calls #make_api_call with id in params' do
      expect(subject).to receive(:make_api_call).with(:put, 14, { foo: 'bar' })
      subject.update(foo: 'bar', id: 14)
    end
  end
end
