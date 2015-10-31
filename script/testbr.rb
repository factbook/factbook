# encoding: utf-8
#
#  use to run/test:
#   ruby -I ./lib script/testbr.rb

require 'factbook'

page = Factbook::Page.new( 'br' )   # br is the country code for Brazil
pp page.data                        # pretty print hash

