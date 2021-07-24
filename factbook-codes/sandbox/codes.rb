###
#  (double) check country and region names of codes via the datasets
#
#  to run use
#     ruby sandbox/codes.rb

$LOAD_PATH.unshift( './lib' )
require 'factbook/codes'


require 'webget'   # note: incl. webcache



codes = Factbook.codes
puts "codes (#{codes.size})"
puts


## match "old / classic" names to new names
##
##  todo/check: change/update region names in data/codes.csv - why? why not?
regions = {
   'Australia - Oceania'      => 'Australia-Oceania',
   'East Asia/Southeast Asia' => 'East & Southeast Asia',
   'Central America'          => 'Central America and Caribbean',
}



codes.each do |cty|   ## note: use country/cty instead of code - why? why not?
  json = Webcache.read( cty.data_url )
  data = JSON.parse( json )

  code    = data['code']
  name    = data['name']
  region  = regions[ data['region']] || data['region']


  print code
  print " - "
  print name
  print " / "
  print region
  print "  -- "
  print cty.category
  print "\n"


  if code.downcase != cty.code
    puts "!! code mismatch - #{cty.code}  <=> #{code.downcase}"
  end

  if name != cty.name
    puts "!! name mismatch - #{cty.name}  <=> #{name}"
  end

  if region != cty.region
    puts "!! region mismatch - #{cty.region}  <=> #{region}"
  end
end


puts "bye"
