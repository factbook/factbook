

require 'factbook/codes'



# our own code
require 'factbook-fields/version' # let it always go first

require 'factbook-fields/category'
require 'factbook-fields/field'
require 'factbook-fields/profile'

require 'factbook-fields/builder'

require 'factbook-fields/comparisons'

## note: make codes, comparisons available
module Factbook
  ##  note: load on demand only builtin codes, comparisons, etc.
  ##          for now
  def self.comparisons
    @@comparisons ||= Comparisons.read_csv( "#{Factbook::Module::Fields.root}/data/comparisons.csv" )
  end
end # module Factbook




puts Factbook::Module::Fields.banner
