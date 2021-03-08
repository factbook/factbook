###
#  to run use
#     ruby -I ./lib -I ./test test/test_html.rb


require 'helper'


class TestHtml < MiniTest::Test


  def test_html
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

       path = "#{Factbook::Test.data_dir}/json/#{code}.json"
       page = Factbook::Page.read_json( path )

       html = page.to_html
       puts html

       ### save to html
       puts "saving a copy to #{code}.html for debugging"
       File.open( "tmp/#{code}.html", 'w:utf-8' ) do |f|
         f.write( html )
      end
     end
  end

end # class TestHtml
