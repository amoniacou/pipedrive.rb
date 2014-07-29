require 'spec_helper'

RSpec.describe ::Pipedrive::Person do
  subject { described_class.new('token') }
  context '#entity_name' do
    subject { super().entity_name }
    it { is_expected.to eq('persons') }
  end

  context '#find_by_name' do
    it 'should call #make_api_call with term' do
      expect(subject).to receive(:make_api_call).with(:get, {term: 'term'})
      subject.find_by_name('term')
    end
    it 'should call #make_api_call with term and search_by_email' do
      expect(subject).to receive(:make_api_call).with(:get, {term: 'term', search_by_email: 1})
      subject.find_by_name('term', true)
    end
  end
end