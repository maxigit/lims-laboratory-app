# vi: ts=2:sts=2:et:sw=2 spell:spelllang=en 
require 'common'

require 'lims-core/resource'

module Lims::LaboratoryApp
  module Organization
    # A study. It as an owner, a title and data release attributes, EGA accession number.
    # Correspond roughly to a published paper.
    class Study
      include Lims::Core::Resource
    end
  end
end

