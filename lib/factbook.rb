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
require 'factbook/page'
require 'factbook/sect'
require 'factbook/codes'


module Factbook
  
  ##  auto-load builtin codes
  CODES = Codes.from_csv( "#{Factbook.root}/data/codes.csv" )

  def self.codes() CODES; end

end # module Factbook


puts Factbook.banner     if defined?($RUBYLIBS_DEBUG) && $RUBYLIBS_DEBUG
