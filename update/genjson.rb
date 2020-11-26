###
#  (re)generate json datasets from (cached) pages
#
#
#
#  use to run:
#   ruby -I ./factbook-readers/lib update/genjson.rb



OUT_ROOT = './tmp/json'
## OUT_ROOT = 'c:/sites/factbook/factbook.json'



require 'factbook/readers'

##
##  todo: mae region_to_slug into a utility method for (re)use - how, why? why not??
def region_to_slug( text )
  ##  change and  =>  n
  ##  change  &   =>  n
  ##  change all spaces to => -
  ##   e.g. East & Southeast Asia          => east-n-southeast-asia
  ##        Central America and Caribbean  => central-america-n-caribbean
  text.downcase.gsub('and', 'n').gsub( '&', 'n' ).gsub( ' ', '-' )
end


## for debugging select some codes
codes = Factbook.codes.select {|code| ['us', 'au'].include?(code.code) }

# codes = Factbook.codes

i = 0
codes.each do |code|
  puts "[#{i+1}/#{codes.size}]:"
  pp code

  url = "https://www.cia.gov/library/publications/the-world-factbook/geos/#{code.code}.html"

  html = Webcache.read( url )
  page = Factbook::Page.new( code.code, html: html )

  region_slug = region_to_slug( code.region )
  path = "#{OUT_ROOT}/#{region_slug}/#{code.code}.json"

  FileUtils.mkdir_p( File.dirname( path ) )    ## make sure path exist


  puts "Saving #{code.code}- #{code.name} to >#{path}<..."
  File.open( path, 'w:utf-8' ) do |f|
    ## note: convert to unix newlines only
    f.write( JSON.pretty_generate( page.data ).gsub( "\r\n", "\n" ))
  end

  i += 1
end

puts "bye"