

desc 'generate html pages for factbook.github.io repo (_profiles)'
task :html do

  ##  todo: add DEBUG flag to use ./build flag with limit - why? why not?

  out_root = debug? ? './build' : FACTBOOK_SITE_PATH

  i=0
  Factbook.codes.each do |code|
     i += 1
     ### next if i > 3    ## for debuging

     puts "(#{i}) Reading page #{code.code}- #{code.name}..."

     puts "code:"
     pp code
# e.g. #<struct Factbook::Codes::Code
# code="ag",
# name="Algeria",
# category="Countries",
# region="Africa">

     html_ascii = read_html( code.code )
     ## use/fix: ASCII-8BIT (e.g.keep as is) -???
     html, info, errors = Factbook::Sanitizer.new.sanitize( html_ascii )

     puts "errors:"
     pp errors
     puts "info:"
     pp info

     path = "#{out_root}/_profiles/#{code.code}.html"

     ## make sure path exist
     FileUtils.mkdir_p( File.dirname( path ) )


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


     ### save to html  - add save as utf-8 - why? why not???
     puts "  saving a copy to >#{path}<..."
     File.open( path, 'w') do |f|
       f.write header
       f.write html
     end
  end
end
