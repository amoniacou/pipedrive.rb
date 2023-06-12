# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Pipedrive::OrganizationField do
  subject { described_class.new('token') }

  describe '#entity_name' do
    subject { super().entity_name }

    it { is_expected.to eq('organizationFields') }
  end
end
