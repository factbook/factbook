## 3rd party gems/libs
## require 'props'

require 'logutils'
require 'webget'
require 'csvreader'


require 'nokogiri'




# our own code
require 'factbook-readers/version' # let it always go first


require 'factbook-readers/codes'
require 'factbook-readers/comparisons'


## note: make codes, comparisons available
module Factbook
  ##  note: load on demand only builtin codes, comparisons, etc.
  ##          for now
  def self.codes
    @@codes       ||= Codes.read_csv( "#{Factbook::Module::Readers.root}/data/codes.csv" );
  end
  def self.comparisons
    @@comparisons ||= Comparisons.read_csv( "#{Factbook::Module::Readers.root}/data/comparisons.csv" )
  end
end # module Factbook



require 'factbook-readers/utils'
require 'factbook-readers/utils_info'
require 'factbook-readers/sanitizer'
require 'factbook-readers/normalize'
require 'factbook-readers/builder_item'
require 'factbook-readers/builder'
require 'factbook-readers/builder_json'
require 'factbook-readers/page'
require 'factbook-readers/page_info'
require 'factbook-readers/sect'
require 'factbook-readers/subsect'


require 'factbook-readers/reader_json'

require 'factbook-readers/table'    ## e.g. TableReader

require 'factbook-readers/counter'




puts Factbook::Module::Readers.banner
