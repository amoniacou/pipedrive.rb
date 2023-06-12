# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Pipedrive::Operations::Create do
  subject do
    Class.new(Pipedrive::Base) do
      include Pipedrive::Operations::Create
    end.new('token')
  end

  describe '#create' do
    it 'calls #make_api_call' do
      expect(subject).to receive(:make_api_call).with(:post, { foo: 'bar' })
      subject.create(foo: 'bar')
    end
  end
end
