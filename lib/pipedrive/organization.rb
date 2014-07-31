module Pipedrive
  class Organization < Base
    include ::Pipedrive::Operations::Read
    include ::Pipedrive::Operations::Create
    include ::Pipedrive::Operations::Update
    include ::Pipedrive::Operations::Delete
  end
end
