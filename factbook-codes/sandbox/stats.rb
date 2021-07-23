###
#  to run use
#     ruby -I ./lib sandbox/stats.rb

require 'factbook/codes'


codes = Factbook.codes
puts "codes (#{codes.size})"
puts


codes.each do |code|
  print code.code
  print "  "
  print "%-32s" % code.name
  print "  "
  print "%-28s" % code.category
  print "  "
  print "%-s" % code.region
  print "\n"
end
puts


categories = codes.categories
puts "categories (#{categories.size}):"
pp categories

regions = codes.regions
puts "regions (#{regions.size}):"
pp regions


puts "urls:"
puts codes[0].data_url
puts codes[0].url( :json )



puts "bye"