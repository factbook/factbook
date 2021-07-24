###
#   build field definitons page (from web cache), that is, DEFINITIONS.md
#
#  to run use
#     ruby sandbox/definitions_build.rb


$LOAD_PATH.unshift( '../factbook-codes/lib' )
$LOAD_PATH.unshift( './lib' )
require 'factbook/fields'




require 'webget'   # note: incl. webcache



ids = [279,280,281,282,283,284,285]


buf = String.new('')   ## dependency page buffer


def field_url( id )
  "https://www.cia.gov/the-world-factbook/fields/#{id}.json"
end


ids.each do |id|
  url = field_url( id )
  json = Webcache.read( url )
  data = JSON.parse( json )

  field_name = data['field_name']
  field_id   = data['field_id']
  field_def  = data['definition']

  buf << "**#{field_name} (##{field_id})**\n<br>"
  buf << field_def
  buf << "\n\n"
end



puts "==> defs:"
puts buf


puts "bye"
