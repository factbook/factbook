###
#  to run use
#     ruby -I ./lib -I ./test test/test_fields.rb

require 'helper'


class TestFields < MiniTest::Test

  def read_test_page( code )
    path = "#{Factbook::Module::Readers.root}/../testdata/json/#{code}.json"
    page = Factbook::Page.read_json( path )
    page
  end


  def test_fields_au
    page = read_test_page( 'au' )  # note: use builtin test page (do NOT fetch via internet)

    assert_equal '-0.7% (of GDP) (2017 est.)',
                  page['Economy']['Budget surplus (+) or deficit (-)']['text']
    assert_equal '0.7%',
                  page['Economy']['Labor force - by occupation']['agriculture']['text']

    assert_equal 'Enns, Krems, Linz, Vienna (Danube)',
                 page['Transportation']['Ports and terminals']['river port(s)']['text']
  end


  def strip_tags( text )
    ## simple quick and dirty helper
    text = text.gsub( '<p>', '' )
    text = text.gsub( '</p>', '' )
    text = text.gsub( '<strong>', '' )
    text = text.gsub( '</strong>', '' )
    text
  end

  def test_fields_br
    ## check fields from readme
    page = read_test_page( 'br' )  # note: use builtin test page (do NOT fetch via internet)

    assert strip_tags( page['Introduction']['Background']['text'] ).start_with?(
              'Following more than three centuries' )
    assert_equal '8,515,770 sq km',
                 page['Geography']['Area']['total']['text']
    assert_equal '8,358,140 sq km',
                 page['Geography']['Area']['land']['text']
    assert_equal '157,630 sq km',
                 page['Geography']['Area']['water']['text']
    assert strip_tags( page['Geography']['Area']['note'] ).start_with?(
         'note: includes Arquipelago de Fernando de Noronha, Atol das Rocas,' )
    assert_equal 'slightly smaller than the US',
                 page['Geography']['Area - comparative']['text']
    assert_equal 'mostly tropical, but temperate in south',
                 page['Geography']['Climate']['text']
    assert page['Geography']['Terrain']['text'].start_with?(
         'mostly flat to rolling lowlands in north;' )
    assert_equal 'Atlantic Ocean 0 m',
                 page['Geography']['Elevation']['lowest point']['text']
    assert_equal 'Pico da Neblina 2,994 m',
                 page['Geography']['Elevation']['highest point']['text']
    assert page['Geography']['Natural resources']['text'].start_with?(
         'alumina, bauxite, beryllium, gold, iron ore, manganese, nickel,' )
  end

end # class TestFields
