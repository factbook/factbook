# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_json_builder.rb


require 'helper'


class TestJsonBuilder < MiniTest::Test

  def test_read
    code = 'au'
    b = Factbook::JsonBuilder.from_file( "#{Factbook.root}/test/data/json/#{code}.json" )
    
    assert_equal 10, b.sects.size
    assert_equal  1, b.sects[0].subsects.size   ## e.g. Introduction/Background
    assert_equal 'Central Europe, north of Italy and Slovenia', b.json['Geography']['Location']['text']

    assert true    ## assume everthing ok
  end

end # class TestJsonBuilder

