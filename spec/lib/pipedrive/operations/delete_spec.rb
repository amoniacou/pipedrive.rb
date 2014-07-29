require 'spec_helper'

RSpec.describe ::Pipedrive::Operations::Delete do
  subject do
    Class.new(::Pipedrive::Base) do
      include ::Pipedrive::Operations::Delete
    end.new('token')
  end

  context '#delete' do
    it 'should call #make_api_call' do
      expect(subject).to receive(:make_api_call).with(:delete, 12)
      subject.delete(12)
    end
  end
  context '#delete_all' do
    it 'should call #make_api_call' do
      expect(subject).to receive(:make_api_call).with(:delete)
      subject.delete_all
    end
  end
end