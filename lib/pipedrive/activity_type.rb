# frozen_string_literal: true

module Pipedrive
  class ActivityType < Base
    include ::Pipedrive::Operations::Create
    include ::Pipedrive::Operations::Read
    include ::Pipedrive::Operations::Update
    include ::Pipedrive::Operations::Delete

    def entity_name
      'activityTypes'
    end
  end
end
