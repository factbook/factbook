###
#  to run use
#     ruby -I ./lib -I ./test test/test_counter.rb

require 'helper'


class TestCounter < MiniTest::Test

  def read_test_page( code )
    html = File.read( "#{Factbook.root}/test/data/src/#{code}.html" )
    page = Factbook::Page.new( code, html: html )
  end

  def test_counter
    c = Factbook::Counter.new

    codes = %w(au be)
    codes.each do |code|
      c.count( read_test_page( code ))  # use builtin test page (do NOT fetch via internet)
    end

    h = c.data
    pp h

    assert true    ## assume everything ok if we get here
  end

end # class TestCounter
