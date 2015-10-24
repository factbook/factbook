# encoding: utf-8

## stdlibs

require 'net/http'
require 'uri'
require 'cgi'
require 'pp'
require 'json'
require 'csv'
require 'fileutils'


## 3rd party gems/libs
## require 'props'

require 'logutils'
require 'fetcher'
require 'nokogiri'


# our own code

require 'factbook/version' # let it always go first
require 'factbook/utils'
require 'factbook/utils_info'
require 'factbook/sanitizer'
require 'factbook/builder'
require 'factbook/page'
require 'factbook/sect'
require 'factbook/subsect'
require 'factbook/item'

require 'factbook/codes'
require 'factbook/comparisons'

require 'factbook/table'    ## e.g. TableReader



module Factbook
  
  ##  auto-load builtin codes and comparisons
  CODES       = Codes.from_csv( "#{Factbook.root}/data/codes.csv" )
  COMPARISONS = Comparisons.from_csv( "#{Factbook.root}/data/comparisons.csv")

  def self.codes()       CODES; end
  def self.comparisons() COMPARISONS; end

end # module Factbook


puts Factbook.banner     if defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG
