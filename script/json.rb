# encoding: utf-8
#
#  use to run:
#   ruby -I ./lib script/json.rb

require 'factbook'

Factbook.codes.each do |code|
  puts "Fetching #{code.code}- #{code.name}..."
  page = Factbook::Page.new( code.code )

  puts "Saving #{code.code}- #{code.name}..."
  File.open( "./tmp/#{code.code}.json", 'w') do |f|
    f.write JSON.pretty_generate( page.data )
  end
end

puts "Done."
