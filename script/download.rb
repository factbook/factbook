#  helper
#  - only download (cache) pages if NOT already in (local web) cache
#
#  use to run:
#   ruby -I ./lib script/download.rb

require 'factbook'



codes = Factbook.codes

i = 0
codes.each do |code|
  puts "[#{i+1}/#{codes.size}]:"
  pp code

  url = "https://www.cia.gov/library/publications/the-world-factbook/geos/#{code.code}.html"

  if Webcache.exist?( url )
    puts "  skipping (already in cache)"
  else
    res = Webget.page( url )
    if res.status.nok?
       puts "!! ERROR - download page:"
       pp res
       exit 1
    end
  end

  i += 1
end
