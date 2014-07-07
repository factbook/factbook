# encoding: utf-8

## stdlibs

require 'net/http'
require 'uri'
require 'cgi'
require 'pp'


## 3rd party gems/libs
## require 'props'

require 'logutils'
require 'fetcher'
require 'nokogiri'


# our own code

require 'factbook/version' # let it always go first
require 'factbook/page'


module Factbook

  def self.banner
    "factbook/#{VERSION} on Ruby #{RUBY_VERSION} (#{RUBY_RELEASE_DATE}) [#{RUBY_PLATFORM}]"
  end

  def self.root
    "#{File.expand_path( File.dirname(File.dirname(__FILE__)) )}"
  end

end # module Factbook


puts Factbook.banner

