# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_convert.rb

require 'helper'


class TestConvert < MiniTest::Test

  def test_au
    im = Factbook::Importer.new
    
    ###########
    ## Geography
    assert_equal 83_871, im.sq_km( "83,871 sq km" )  ## page.area       
    assert_equal 82_445, im.sq_km( "82,445 sq km" )  ## page.area_land
    assert_equal  1_426, im.sq_km( "1,426 sq km" )   ## page.area_water

    ###################
    ## People and Society
    assert_equal 8_665_550, im.num( "8,665,550 (July 2015 est.)" )  ## page.population  
    assert_equal 0.55,      im.percent( "0.55% (2015 est.)" ) ## page.population_growth
    assert_equal 9.41,      im.rate_per_thousand( "9.41 births/1,000 population (2015 est.)" ) ## page.birth_rate
    assert_equal 9.42,      im.rate_per_thousand( "9.42 deaths/1,000 population (2015 est.)" ) ## page.death_rate
    assert_equal 5.56,      im.rate_per_thousand( "5.56 migrant(s)/1,000 population (2015 est.)" ) ## page.migration_rate
  end

end # class TestConvert
