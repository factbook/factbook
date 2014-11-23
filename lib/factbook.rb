# encoding: utf-8

## stdlibs
require 'net/http'
require 'uri'
require 'cgi'
require 'pp'
require 'json'
require 'fileutils'

## 3rd party gems/libs
require 'logutils'
require 'fetcher'
require 'nokogiri'

# our own code
require 'factbook/version' # let it always go first
require 'factbook/page'
require 'factbook/sect'




puts Factbook.banner

