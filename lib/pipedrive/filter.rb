module Pipedrive
  class Filter < Base
    include ::Pipedrive::Operations::Read
    include ::Pipedrive::Operations::Delete
  end
end
