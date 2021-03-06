# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en

require 'lims-laboratory-app/organization/batch/batch_persistor'
require 'lims-core/persistence/sequel/persistor'

module Lims::LaboratoryApp
  module Organization
    class Batch
      class BatchSequelPersistor < BatchPersistor
        include Lims::Core::Persistence::Sequel::Persistor

        def self.table_name
          :batches
        end
      end
    end
  end
end
