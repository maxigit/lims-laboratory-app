# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en


require 'lims-core/persistence/persistor'
require 'lims-laboratory-app/laboratory/tube'
require 'lims-laboratory-app/laboratory/aliquot/all'

module Lims::LaboratoryApp
  module Laboratory

    # Base for all Tube persistor.
    # Real implementation classes (e.g. Sequel::Tube) should
    # include the suitable persistor.
    class Tube
      module TubeAliquot
        SESSION_NAME = :tube_persistor_aliquot
        class TubeAliquotPersistor < Lims::Core::Persistence::Persistor
        end
      end
      class TubePersistor < Lims::Core::Persistence::Persistor
        # this module is here only to give 'parent' class for the persistor
        # to be associated 
        Model = Laboratory::Tube

        # Save all children of the given tube
        # @param  id object identifier
        # @param [Laboratory::Tube] tube
        # @return [Boolean]
        def save_children(id, tube)
          # we use values here, so position is a number
          tube.each do |aliquot|
            tube_aliquot.save_as_aggregation(id, aliquot)
          end
        end

        def  tube_aliquot
          @session.tube_persistor_aliquot
        end


        # Load all children of the given tube
        # Loaded object are automatically added to the session.
        # @param  id object identifier
        # @param [Laboratory::Tube] tube
        # @return [Laboratory::Tube, nil] 
        #
        def load_children(id, tube)
          tube_aliquot.load_aliquots(id) do |aliquot|
            tube << aliquot
          end
        end
      end
    end
  end
end
