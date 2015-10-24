# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_page.rb


require 'helper'


class TestPage < MiniTest::Test


  def test_sects
    pages = [
      [ 'au', 10 ],
      [ 'be', 10 ],
#      [ 'br', 10 ],
#      [ 'ee', 10 ],
#      [ 'mx', 10 ],
#      [ 'xx', 10 ],
#      [ 'ls', 9  ],
#      [ 'vt', 8  ],
      ]
    
    pages.each do |rec|
        code       = rec[0]
        sects_size = rec[1]

        b = Factbook::Builder.from_file( "#{Factbook.root}/test/data/src/#{code}.html" )
        page = b.page
       
        ##  page = Factbook::OldPage.new( code )    
        ## page.html = File.read( "#{Factbook.root}/test/data/old/countrytemplate_#{code}.html" )

        ## print first 600 chars
        ## pp page.html[0..600]

        assert_equal sects_size, page.sects.size
    end
  end


end # class TestPage
