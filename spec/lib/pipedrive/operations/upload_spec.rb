require 'spec_helper'

RSpec.describe ::Pipedrive::Operations::Upload do
  subject do
    Class.new(::Pipedrive::Base) do
      include ::Pipedrive::Operations::Upload

      def entity_name
        'bases'
      end
    end.new('token')
  end

  context '#upload' do
    it 'should make a multipart api call' do
      stub_request(:post, 'https://api.pipedrive.com/v1/bases?api_token=token').to_return(:status => 200, :body => {}.to_json, :headers => {})
      expect_any_instance_of(::Faraday::Connection).to(receive(:post).with('/v1/bases?api_token=token', hash_including(
        file: an_instance_of(Faraday::UploadIO),
        deal_id: an_instance_of(Faraday::ParamPart)
      ))).and_call_original

      subject.upload('./Gemfile', 'text/plain', deal_id: 123)
    end
  end
end
