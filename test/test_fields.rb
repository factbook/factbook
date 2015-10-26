# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_fields.rb

require 'helper'


class TestFields < MiniTest::Test

  def read_test_page( code )
    b = Factbook::Builder.from_file( "#{Factbook.root}/test/data/src/#{code}.html" )
    b.page    
  end

  def test_fields_full
    ## Factbook::Page.new( 'au', fields: 'full' )
    page = read_test_page( 'au' )  # use builtin test page (do NOT fetch via internet)

    assert_equal '-2.4% of GDP (2014 est.)', page['Economy']['Budget surplus (+) or deficit (-)']['text']
    assert_equal '5.5%',  page['Economy']['Labor force - by occupation']['agriculture']['text']

    assert_equal 'Enns, Krems, Linz, Vienna (Danube)', page['Transportation']['Ports and terminals']['river port(s)']['text']
  end

  def fix_xxx_test_fields_full_w_header
    page = Factbook::OldPage.new( 'au', header: true, fields: 'full' )
    page.html = read_test_page( 'au' )  # use builtin test page (do NOT fetch via internet)

    assert_equal 'au', page['Header']['code']
    assert_equal "factbook/#{Factbook::VERSION}", page['Header']['generator']

    assert_equal '-2.4% of GDP (2014 est.)', page['Economy']['Budget surplus (+) or deficit (-)']['text']
    assert_equal '5.5%',  page['Economy']['Labor force - by occupation']['agriculture']

    assert_equal 'Enns, Krems, Linz, Vienna (Danube)', page['Transportation']['Ports and terminals']['river port(s)']
  end

  def fix_xxx_test_fields_std
    page = Factbook::OldPage.new( 'au' )
    page.html = read_test_page( 'au' )  # use builtin test page (do NOT fetch via internet)

    assert_equal '-2.4% of GDP (2014 est.)', page['econ']['budget_surplus_or_deficit']['text']
    assert_equal '5.5%',  page['econ']['labor_force_by_occupation']['agriculture']

    assert_equal 'Enns, Krems, Linz, Vienna (Danube)', page['trans']['ports_and_terminals']['river_ports']
  end


end # class TestFields
