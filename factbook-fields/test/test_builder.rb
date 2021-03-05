###
#  to run use
#     ruby -I ./lib -I ./test test/test_builder.rb


require 'helper'


class TestBuilder < MiniTest::Test

  def test_read
    code = 'au'
    path = "#{Factbook::Module::Fields.root}/../testdata/json/#{code}.json"
    profile = Factbook::Profile.read( path )

    assert_equal 11, profile.size
    assert_equal  1, profile[0].size                ## e.g. Introduction/Background
    assert_equal  1, profile['Introduction'].size   ## e.g. Introduction/Background

    assert_equal 'Central Europe, north of Italy and Slovenia',
                 profile['Geography']['Location']['text']
    assert_equal '83,871 sq km',
                 profile['Geography']['Area']['total']['text']


    assert true    ## assume everthing ok
  end

end # class TestBuilder

