# encoding: utf-8
#
#  use to run/test:
#   ruby -I ./lib script/testbr.rb

require 'factbook'

page = Factbook::Page.new( 'br' )   # br is the country code for Brazil
pp page.data                        # pretty print hash

puts "background:"
pp page.background        ## same as page['Introduction']['Background']['text']
puts "area:"
pp page.area              ## same as page['Geography'][''Area']['total']['text']
puts "area_land:"
pp page.area_land         ## same as page['Geography'][''Area']['land']['text']
puts "area_water:"
pp page.area_water        ## same as page['Geography'][''Area']['water']['text']
puts "area_note:"
pp page.area_note         ## same as page['Geography'][''Area']['note']['text']
puts "area comparative:"
pp page.area_comparative  ## same as page['Geography']['Area - comparative']['text']
puts "climate:"
pp page.climate           ## same as page['Geography']['Climate']['text']
puts "terrain:"
pp page.terrain           ## same as page['Geography']['Terrain']['text']
puts "elevation_lowest:"
pp page.elevation_lowest  ## same as page['Geography']['Elevation extremes']['lowest point']['text']
puts "elevation_highest:"
pp page.elevation_highest ## same as page['Geography']['Elevation extremes']['highest point']['text']
puts "resources:"
pp page.resources         ## same as page['Geography'][Natural resources']['text']

