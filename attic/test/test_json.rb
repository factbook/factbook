# encoding: utf-8


require 'helper'


class TestOldJson < MiniTest::Test


  def test_json
     Dir.mkdir( 'tmp' )  unless Dir.exists?( 'tmp' )
     
     codes = [ 'au',
               'be',
               'br',
               'mx',
               'ls',
               'vt',
               'ee',
               'xx' ]

     codes.each do |code|
       page = Factbook::OldPage.new( code )    
       page.html = File.read( "#{Factbook.root}/test/data/old/countrytemplate_#{code}.html" )

       ## print first 600 chars
       pp page.html[0..600]

       ## save for debuging
    
       puts "saving a copy to #{code}.html for debugging"
       File.open( "tmp/#{code}.html", 'w' ) do |f|
        f.write page.html 
       end

       h = page.data
       pp h
    
       ### save to json
       puts "saving a copy to #{code}.json for debugging"
       File.open( "tmp/#{code}.json", 'w' ) do |f|
        f.write JSON.pretty_generate( h )
      end
     end
  end

end # class TestOldJson
