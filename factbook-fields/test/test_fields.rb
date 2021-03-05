###
#  to run use
#     ruby -I ./lib -I ./test test/test_fields.rb


require 'helper'


class TestFields < MiniTest::Test

  def test_fields_new

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


  def test_fields_au
    # note: use builtin test page (do NOT fetch via internet)
    code = 'au'
    path = "#{Factbook::Module::Fields.root}/../testdata/json/#{code}.json"
    profile  = Factbook::Profile.read( path )

    assert_equal '-0.7% (of GDP) (2017 est.)',
                  profile['Economy']['Budget surplus (+) or deficit (-)']['text']
    assert_equal '0.7%',
                  profile['Economy']['Labor force - by occupation']['agriculture']['text']

    assert_equal 'Enns, Krems, Linz, Vienna (Danube)',
                 profile['Transportation']['Ports and terminals']['river port(s)']['text']
  end



end # class TestFields

