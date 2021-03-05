###
#  to run use
#     ruby -I ./lib -I ./test test/test_counter.rb

require 'helper'


class TestCounter < MiniTest::Test

  def read_test_page( code )
    path = "#{Factbook::Module::Readers.root}/../testdata/json/#{code}.json"
    page = Factbook::Page.read_json( path )
    page
  end


  def test_counter
    counter = Factbook::Counter.new

    codes = ['au', 'be']
    codes.each do |code|
      page = read_test_page( code )
      counter.count( code, page )  # use builtin test page (do NOT fetch via internet)
    end

    h = counter.data
    pp h

    assert true    ## assume everything ok if we get here
  end

end # class TestCounter
