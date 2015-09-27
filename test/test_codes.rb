# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_codes.rb


require 'helper'


class TestCodes < MiniTest::Test


  def test_codes
    
    assert_equal 261, Factbook::CODES.size
    assert_equal 261, Factbook.codes.size 
    assert_equal 261, Factbook.codes.to_a.size


    assert_equal 195, Factbook.codes.countries.size
    assert_equal  52, Factbook.codes.dependencies.size
    assert_equal   8, Factbook.codes.dependencies_us.size

    assert_equal   5, Factbook.codes.oceans.size
    assert_equal   1, Factbook.codes.world.size
    assert_equal   2, Factbook.codes.others.size
    assert_equal   6, Factbook.codes.misc.size
    
    assert_equal  55, Factbook.codes.europe.size
    assert_equal  45, Factbook.codes.countries.europe.size
    ## todo/fix: add all other regions (north america etc. too)
    
    
    assert_equal 261, Factbook.codes.countries.size +
                      Factbook.codes.others.size +
                      Factbook.codes.dependencies.size +
                      Factbook.codes.misc.size +
                      Factbook.codes.oceans.size +
                      Factbook.codes.world.size
                    
  end

end # class TestCodes


