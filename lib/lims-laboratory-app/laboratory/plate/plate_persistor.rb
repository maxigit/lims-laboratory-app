# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en

require 'lims-core/persistence/persistor'
require 'lims-laboratory-app/laboratory/container/container_persistor'
require 'lims-laboratory-app/laboratory/container/container_element_persistor'
require 'lims-laboratory-app/laboratory/plate'

module Lims::LaboratoryApp
  module Laboratory

    # Base for all Plate persistor.
    # Real implementation classes (e.g. Sequel::Plate) should
    # include the suitable persistor.
    class Plate
      class PlatePersistor < Lims::Core::Persistence::Persistor
        Model = Laboratory::Plate

        include Container::ContainerPersistor

        # calls the correct element method
        def element
          well
        end

        def well
          @session.plate_well
        end
      end

      # Base for all Well persistor.
      # Real implementation classes (e.g. Sequel::Well) should
      # include the suitable persistor.
      class Well
        SESSION_NAME = :plate_well
        class WellPersistor < Lims::Core::Persistence::Persistor
          Model = Laboratory::Plate::Well

          include Container::ContainerElementPersistor

        end
      end
    end
  end
end
