require 'lims-core/resource'
require 'lims-laboratory-app/laboratory/receptacle.rb'

module Lims::LaboratoryApp
  module Laboratory
    # Piece of labware. 
    # Can have something on it.
    # It can have a label (barcode) to identify it.
    class SpinColumn
      include Lims::Core::Resource
      include Receptacle
    end
  end
end
