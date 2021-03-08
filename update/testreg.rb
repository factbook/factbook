###
#  use to run:
#   ruby update/testreg.rb


require_relative 'helper'


## test codes with region (folder)
codes = Factbook.codes
codes.each do |code|
    puts "#{code.region_slug}/#{code.code}  -- #{code.name}"
end

puts "bye"
