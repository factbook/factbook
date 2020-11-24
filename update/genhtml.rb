###
#  (re)generate "chrome-less" html pages from (cached) pages
#
#
#
#  use to run:
#   ruby -I ./lib update/genhtml.rb



OUT_ROOT = './tmp/html'
## OUT_ROOT = 'c:/sites/factbook/factbook.github.io'



require 'factbook'


codes = Factbook.codes

i = 0
codes.each do |code|
     ## next if i > 3    ## for debuging

     puts "[#{i+1}/#{codes.size}] reading page #{code.code}- #{code.name}..."

     puts "code:"
     pp code
# e.g. #<struct Factbook::Codes::Code
# code="ag",
# name="Algeria",
# category="Countries",
# region="Africa">

     url = "https://www.cia.gov/library/publications/the-world-factbook/geos/#{code.code}.html"

     html = Webcache.read( url )

     html, info, errors = Factbook::Sanitizer.new.sanitize( html )

     puts "errors:"
     pp errors
     puts "info:"
     pp info

     path = "#{OUT_ROOT}/_profiles/#{code.code}.html"

     FileUtils.mkdir_p( File.dirname( path ) )  ## make sure path exist


     ## note:
     ##  use double quotes for country name - may include commas e.g Korea, Republic etc.
     header =<<EOS
---
layout:       country
title:        "#{code.code} - #{code.name}"
permalink:    #{code.code}.html
last_updated: #{info.last_updated ? info.last_updated.strftime('%Y-%m-%d') : ''}
country_code: #{code.code}
country_name: "#{code.name}"
country_affiliation: #{info.country_affiliation}
region_code:  #{info.region_code}
region_name:  #{code.region}
---

EOS

## todo:
##   in future use all info (if present? why? why not?)
##   e.g. info.region_name  (instead of code.region)
##        info.country_code (instead of code.code)
#         info.country_name (instead of code.name)


  puts "  saving a copy to >#{path}<..."
  File.open( path, 'w:utf-8' ) do |f|
    f.write( header )
    f.write( html )
  end

  i += 1
end


puts "bye"

