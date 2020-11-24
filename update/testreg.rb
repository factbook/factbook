###
#  use to run:
#   ruby -I ./lib update/testreg.rb


require 'factbook'


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


## test codes with region (folder)
codes = Factbook.codes
codes.each do |code|
    region_slug = region_to_slug( code.region )
    puts "#{region_slug}/#{code.code}  -- #{code.name}"
end

puts "bye"