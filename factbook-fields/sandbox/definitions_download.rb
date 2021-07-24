###
#   download all field definitions (to cache)
#
#  to run use
#     ruby sandbox/definitions_download.rb


$LOAD_PATH.unshift( '../factbook-codes/lib' )
$LOAD_PATH.unshift( './lib' )
require 'factbook/fields'


require 'webget'   # note: incl. webcache



Webget.config.sleep = 0.5     ## sleep 500 ms (that is, 0.5 secs)




##
#  https://www.cia.gov/the-world-factbook/fields/279.json


=begin
279, Geography, Area
280, Geography, Area - comparative
281, Geography, Land boundaries
282, Geography, Coastline
283, Geography, Maritime claims
284, Geography, Climate
285, Geography, Terrain
=end


## check for field definitions

def field_url( id )
  "https://www.cia.gov/the-world-factbook/fields/#{id}.json"
end


ids = [279,280,281,282,283,284,285]
ids.each do |id|

  url = field_url( id )

  ## todo/fix: check if page exits already? if yes, skip
  res = Webget.call( url )  ## get json dataset / page
  if res.status.nok?
    puts "!! ERROR - download json call:"
    pp res
    exit 1
  end
end

puts "bye"
