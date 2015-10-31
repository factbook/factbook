# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_json.rb


require 'helper'


class TestJson < MiniTest::Test


  def test_json
     Dir.mkdir( 'tmp' )  unless Dir.exists?( 'tmp' )
     
     codes = [ 'au',
               'be',
               #'br',
               #'mx',
               #'ls',
               #'vt',
               #'ee',
               #'xx'
              ]

     codes.each do |code|
       
       html = File.read( "#{Factbook.root}/test/data/src/#{code}.html" ) 
       page = Factbook::Page.new( code, html: html )    
       
       h = page.data
       pp h
    
       ### save to json
       puts "saving a copy to #{code}.json for debugging"
       File.open( "tmp/#{code}.json", 'w' ) do |f|
         f.write JSON.pretty_generate( h )
         ## f.write page.to_json
      end
     end
  end

end # class TestJson
