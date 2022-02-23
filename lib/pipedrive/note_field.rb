module Pipedrive
  class NoteField < Base
    include ::Pipedrive::Operations::Read

    def entity_name
      'noteFields'
    end
  end
end
