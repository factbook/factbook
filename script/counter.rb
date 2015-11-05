# encoding: utf-8
#
#  use to run:
#   ruby -I ./lib script/counter.rb

require 'factbook'


c = Factbook::Counter.new
 
Factbook.codes.each do |code|
  c.count( Factbook::Page.new( code.code ))
end

h = c.data
pp h
    
### save to json
puts "saving a copy to categories.json for debugging"
File.open( "tmp/categories.json", 'w' ) do |f|
  f.write JSON.pretty_generate( h )
end


