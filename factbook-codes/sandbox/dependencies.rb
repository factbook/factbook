###
#  to run use
#     ruby sandbox/dependencies.rb


$LOAD_PATH.unshift( './lib' )
require 'factbook/codes'


require 'webget'   # note: incl. webcache



codes = Factbook.codes
puts "codes (#{codes.size})"
puts



buf = String.new('')   ## dependency page buffer



codes.each do |cty|   ## note: use country/cty instead of code - why? why not?
  json = Webcache.read( cty.data_url )
  data = JSON.parse( json )

  code    = data['code']
  name    = data['name']
  region  = data['region']

  gov = data['categories'].find { |category| category['title'] == 'Government' }
  dependency = gov ?
                 gov['fields'].find { |field| field['name'] == 'Dependency status' }
                   :
                 nil


  if dependency
    geo = data['categories'].find { |category| category['title'] == 'Geography' }
    area = geo['fields'].find { |field| field['name'] == 'Area'}
    area_total = area['subfields'] ?
                   area['subfields'].find { |field| field['name'] == 'total'}
                     :
                    nil

    puts "==> #{code} #{name} / #{region}:"
    pp area
    pp area_total

    buf <<  "**" +
            code +
            "  " +
            name +
            " / " +
            region +
            "** " +
            "  -- " +
            cty.category +
            ", " +
            (area_total ? area_total['content'] : "?") +
            ":\n<br>"
    buf << dependency['content']
    buf << "\n\n"
  end
end


puts "==> deps:"
puts buf


puts "bye"
