###
#  to run use
#     ruby -I ./lib -I ./test test/test_fields.rb


require 'helper'


class TestFields < MiniTest::Test

  def test_fields

    field0 = Factbook::Field.new( 'Location' )
    field0.data  = { 'text' => 'Central Europe, north of Italy and Slovenia' }

    field1 = Factbook::Field.new( 'Geographic coordinates' )
    field1.data  = { 'text' => '47 20 N, 13 20 E' }

    category = Factbook::Category.new( 'Geography' )
    category << field0
    category << field1

    profile = Factbook::Profile.new
    profile << category


    assert_equal 'Central Europe, north of Italy and Slovenia',
                 profile[ 'Geography' ][ 'Location' ][ 'text' ]

    assert_equal '47 20 N, 13 20 E',
                 profile[ 'Geography' ][ 'Geographic coordinates' ][ 'text' ]

    pp profile

    puts
    puts "json:"
    puts profile.to_json
  end

end # class TestFields

