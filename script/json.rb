# encoding: utf-8
#
#  use to run:
#   ruby -I ./lib script/json.rb

require 'factbook'

Factbook.codes.each do |code|
  puts "Fetching #{code.code}- #{code.name}..."
  page = Factbook::Page.new( code.code )

  puts "Saving #{code.code}- #{code.name}..."
  File.open( "./tmp/#{code.code}.json", 'w:utf-8') do |f|
    ## note: convert to unix newlines only
    f.write( JSON.pretty_generate( page.data ).gsub( "\r\n", "\n" )   )
  end
end

puts "Done."
