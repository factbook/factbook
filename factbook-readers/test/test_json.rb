###
#  to run use
#     ruby -I ./lib -I ./test test/test_json.rb


require 'helper'


class TestJson < MiniTest::Test


  def test_json
     Dir.mkdir( 'tmp' )  unless Dir.exists?( 'tmp' )

     codes = [ 'au',
               'ag',
               'be',
               'br',
               #'mx',
               #'ls',
               #'vt',
               #'ee',
               #'xx'
              ]

     codes.each do |code|

       path = "#{Factbook::Module::Readers.root}/../testdata/json/#{code}.json"
       page = Factbook::Page.read_json( path )

       h = page.to_h
       pp h

       ### save to json
       puts "saving a copy to #{code}.json for debugging"
       File.open( "tmp/#{code}.json", 'w:utf-8' ) do |f|
         f.write JSON.pretty_generate( h )
         ## f.write page.to_json
      end
     end
  end

end # class TestJson
