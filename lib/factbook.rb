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
require 'factbook/utils_page'
require 'factbook/builder'
require 'factbook/page'
require 'factbook/sect'
require 'factbook/subsect'
require 'factbook/item'
require 'factbook/codes'


## old version (for old pages) -- move to attic - why? why not??
require 'factbook/old/page'    
require 'factbook/old/sect'



module Factbook
  
  ##  auto-load builtin codes
  CODES = Codes.from_csv( "#{Factbook.root}/data/codes.csv" )

  def self.codes() CODES; end

end # module Factbook


puts Factbook.banner     if defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG
