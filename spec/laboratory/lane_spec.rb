# Spec requirements
require 'laboratory/spec_helper'
require 'laboratory/receptacle_examples'

# Model requirements
require 'lims-laboratory-app/laboratory/flowcell'

module Lims::LaboratoryApp::Laboratory
  describe Flowcell::Lane, :flowcell => true, :lane => true, :laboratory => true  do
    it "belongs  to a flowcell "  # contained by a flowcell
    it_behaves_like "receptacle"
  end
end
