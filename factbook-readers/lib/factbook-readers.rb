require 'factbook-fields'

## more 3rd party gems/libs
## require 'props'
require 'webget'



# our own code
require 'factbook-readers/version' # let it always go first

require 'factbook-readers/comparisons'

## note: make codes, comparisons available
module Factbook
  ##  note: load on demand only builtin codes, comparisons, etc.
  ##          for now
  def self.comparisons
    @@comparisons ||= Comparisons.read_csv( "#{Factbook::Module::Readers.root}/data/comparisons.csv" )
  end
end # module Factbook



require 'factbook-readers/utils'
require 'factbook-readers/utils_info'
require 'factbook-readers/normalize'
require 'factbook-readers/builder_json'
require 'factbook-readers/page'


require 'factbook-readers/reader_json'

require 'factbook-readers/table'    ## e.g. TableReader

require 'factbook-readers/counter'




puts Factbook::Module::Readers.banner
