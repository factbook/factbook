## stdlibs


require 'cgi'
require 'csv'   ## fix: use csvreader!!!!
require 'erb'     ## used by Almanac class (for render)


## 3rd party gems/libs
## require 'props'

require 'logutils'
require 'webget'
require 'nokogiri'

require 'active_record'     ## add activerecord/db support (NOT optional for now)



# our own code
require 'factbook/version' # let it always go first


require 'factbook/codes'
require 'factbook/comparisons'
require 'factbook/attributes'

module Factbook

  ##  auto-load builtin codes, comparisons, attributes, etc.
  CODES       = Codes.from_csv( "#{Factbook.root}/data/codes.csv" )
  COMPARISONS = Comparisons.from_csv( "#{Factbook.root}/data/comparisons.csv" )
  ATTRIBUTES  = Attributes.from_yaml( "#{Factbook.root}/data/attributes.yml" )

  def self.codes()       CODES; end
  def self.comparisons() COMPARISONS; end
  def self.attributes()  ATTRIBUTES; end

end # module Factbook

## note: make codes, comparisons, attributes available

require 'factbook/utils'
require 'factbook/utils_info'
require 'factbook/sanitizer'
require 'factbook/normalize'
require 'factbook/builder_item'
require 'factbook/builder'
require 'factbook/builder_json'
require 'factbook/page'
require 'factbook/page_info'
require 'factbook/sect'
require 'factbook/subsect'

require 'factbook/reader_json'
require 'factbook/almanac'

require 'factbook/table'    ## e.g. TableReader

require 'factbook/counter'

require 'factbook/db/schema'   ## database (sql tables) support
require 'factbook/db/models'
require 'factbook/db/importer'



puts Factbook.banner
