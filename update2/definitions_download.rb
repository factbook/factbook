###
#   download all field definitions (to cache)
#
#  to run use
#     ruby update2/definitions_download.rb


require_relative 'helper'



Webget.config.sleep = 0.5     ## sleep 500 ms (that is, 0.5 secs)




##
#  https://www.cia.gov/the-world-factbook/fields/279.json


## check for field definitions

def field_url( id )
  "https://www.cia.gov/the-world-factbook/fields/#{id}.json"
end


path =  "#{Factbook::Module::Fields.root}/data/fields.csv"

rows = CsvHash.read( path )

puts "#{rows.size} record(s)"


=begin
279, Geography, Area
280, Geography, Area - comparative
281, Geography, Land boundaries
282, Geography, Coastline
283, Geography, Maritime claims
284, Geography, Climate
285, Geography, Terrain
=end

## ids = [279,280,281,282,283,284,285]
## ids.each do |id|

rows.each do |row|

  pp row
  id = row['Num']

  url = field_url( id )

  cached = Webcache.cached?( url )
  if cached
    puts "  skip; use cached version for >#{url}<"
  else
    res = Webget.call( url )  ## get json dataset / page
    if res.status.nok?
      puts "!! ERROR - download json call:"
      pp res
      exit 1
    end
  end
end

puts "bye"
