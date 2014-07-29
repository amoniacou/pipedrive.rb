require 'spec_helper'

RSpec.describe ::Pipedrive::Operations::Read do
  subject do
    Class.new(::Pipedrive::Base) do
      include ::Pipedrive::Operations::Read
    end.new('token')
  end

  context '#find_by_id' do
    it 'should call #make_api_call' do
      expect(subject).to receive(:make_api_call).with(:get, 12)
      subject.find_by_id(12)
    end
  end

  context '#each' do
    let(:additional_data) do
      {pagination: { more_items_in_collection?: true, next_start: 10}}
    end
    it 'should return Enumerator if no block given' do
      expect(subject.each).to be_a(::Enumerator)
    end
    it 'should call to_enum with params' do
      expect(subject).to receive(:to_enum).with(:each, {foo: 'bar'})
      subject.each(foo: 'bar')
    end
    it 'should yield data' do
      expect(subject).to receive(:chunk).and_return(::Hashie::Mash.new(data: [1,2], success: true))
      expect { |b| subject.each(&b)}.to yield_successive_args(1,2)
    end
    it 'should follow pagination' do
      expect(subject).to receive(:chunk).with(start: 0).and_return(::Hashie::Mash.new(data: [1,2], success: true, additional_data: additional_data))
      expect(subject).to receive(:chunk).with(start: 10).and_return(::Hashie::Mash.new(data: [3,4], success: true))
      expect { |b| subject.each(&b)}.to yield_successive_args(1,2,3,4)
    end
    it 'should not yield anything if result is empty' do
      expect(subject).to receive(:chunk).with(start: 0).and_return(::Hashie::Mash.new(success: true))
      expect { |b| subject.each(&b)}.to yield_successive_args
    end
    it 'should not yield anything if result is not success' do
      expect(subject).to receive(:chunk).with(start: 0).and_return(::Hashie::Mash.new(success: false))
      expect { |b| subject.each(&b)}.to yield_successive_args
    end
  end

  context '#all' do
    it 'should call #each' do
      arr = double('enumerator')
      allow(arr).to receive(:to_a)
      expect(subject).to receive(:each).and_return(arr)
      subject.all
    end
  end

  context '#chunk' do
    it 'should return []' do
      res = double('res', success?: false)
      expect(subject).to receive(:make_api_call).with(:get, {}).and_return(res)
      expect(subject.chunk).to eq([])
    end

    it 'should return result' do
      res = double('res', success?: true)
      expect(subject).to receive(:make_api_call).with(:get, {}).and_return(res)
      expect(subject.chunk).to eq(res)
    end
  end
end