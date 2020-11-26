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
require 'factbook-readers/attributes'

module Factbook

  ##  auto-load builtin codes, comparisons, attributes, etc.
  CODES       = Codes.from_csv( "#{Factbook::Module::Readers.root}/data/codes.csv" )
  COMPARISONS = Comparisons.from_csv( "#{Factbook::Module::Readers.root}/data/comparisons.csv" )
  ATTRIBUTES  = Attributes.from_yaml( "#{Factbook::Module::Readers.root}/data/attributes.yml" )

  def self.codes()       CODES; end
  def self.comparisons() COMPARISONS; end
  def self.attributes()  ATTRIBUTES; end

end # module Factbook

## note: make codes, comparisons, attributes available

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
