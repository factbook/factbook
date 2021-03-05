###
#  to run use
#     ruby -I ./lib -I ./test test/test_json_builder.rb


require 'helper'


class TestJsonBuilder < MiniTest::Test

  def test_read
    code = 'au'
    path = "#{Factbook::Module::Readers.root}/../testdata/json/#{code}.json"
    text = File.open( path, 'r:utf-8' ) { |f| f.read }

    b = Factbook::JsonBuilder.new( text )

    profile = b.profile
    assert_equal 11, profile.size
    assert_equal  1, profile[0].size                ## e.g. Introduction/Background
    assert_equal  1, profile['Introduction'].size   ## e.g. Introduction/Background

    assert_equal 'Central Europe, north of Italy and Slovenia',
                 profile['Geography']['Location']['text']
    assert_equal '83,871 sq km',
                 profile['Geography']['Area']['total']['text']


    assert true    ## assume everthing ok
  end

end # class TestJsonBuilder

