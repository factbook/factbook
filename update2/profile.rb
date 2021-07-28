###
#  use to run:
#   ruby update2/profile.rb


require_relative 'helper'



def read_profile( cty )
  json = Webcache.read( cty.data_url )
  data = JSON.parse( json )

  data = convert_cia( data )
  data

  profile = Factbook::Profile.parse( data )
  profile
end



codes = Factbook.codes

cty = codes['au']

profile = read_profile( cty )
pp profile


puts profile.size
puts profile[0].size                ## e.g. Introduction/Background
puts
puts profile['Introduction']['Background']['text']
puts profile['Geography']['Location']['text']
puts profile['Geography']['Area']['total']['text']


puts "profile:"
puts profile.to_markdown

puts "bye"

