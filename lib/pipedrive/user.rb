module Pipedrive
  class User < Base
    include ::Pipedrive::Operations::Create
    include ::Pipedrive::Operations::Read
    include ::Pipedrive::Operations::Update
    include ::Pipedrive::Operations::Delete
  end
end
