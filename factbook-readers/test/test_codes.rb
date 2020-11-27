###
#  to run use
#     ruby -I ./lib -I ./test test/test_codes.rb


require 'helper'


class TestCodes < MiniTest::Test


  def test_codes
    assert_equal 261, Factbook.codes.size
    assert_equal 261, Factbook.codes.to_a.size


    assert_equal 195, Factbook.codes.countries.size
    assert_equal  52, Factbook.codes.dependencies.size
    assert_equal   5, Factbook.codes.oceans.size
    assert_equal   1, Factbook.codes.world.size
    assert_equal   2, Factbook.codes.others.size
    assert_equal   6, Factbook.codes.misc.size

    assert_equal   8, Factbook.codes.dependencies_us.size


    assert_equal  55, Factbook.codes.europe.size
    assert_equal   9, Factbook.codes.south_asia.size
    assert_equal   6, Factbook.codes.central_asia.size
    assert_equal  22, Factbook.codes.east_n_souteast_asia.size
    assert_equal  19, Factbook.codes.middle_east.size
    assert_equal  56, Factbook.codes.africa.size
    assert_equal   7, Factbook.codes.north_america.size
    assert_equal  33, Factbook.codes.central_america_n_caribbean.size
    assert_equal  14, Factbook.codes.south_america.size
    assert_equal  30, Factbook.codes.australia_oceania.size
    assert_equal   4, Factbook.codes.antartica.size
    assert_equal   5, Factbook.codes.region('Oceans').size
    assert_equal   1, Factbook.codes.region('World').size

    assert_equal  45, Factbook.codes.countries.europe.size

    assert_equal  Factbook.codes.category('Oceans').size, Factbook.codes.region('Oceans').size
    assert_equal  Factbook.codes.category('World').size,  Factbook.codes.region('World').size


    assert_equal 261, Factbook.codes.countries.size +
                      Factbook.codes.others.size +
                      Factbook.codes.dependencies.size +
                      Factbook.codes.misc.size +
                      Factbook.codes.oceans.size +
                      Factbook.codes.world.size

    assert_equal 261, Factbook.codes.europe.size +
                      Factbook.codes.south_asia.size +
                      Factbook.codes.central_asia.size +
                      Factbook.codes.east_n_souteast_asia.size +
                      Factbook.codes.middle_east.size +
                      Factbook.codes.africa.size +
                      Factbook.codes.north_america.size +
                      Factbook.codes.central_america_n_caribbean.size +
                      Factbook.codes.south_america.size +
                      Factbook.codes.australia_oceania.size +
                      Factbook.codes.antartica.size +
                      Factbook.codes.region('Oceans').size +
                      Factbook.codes.region('World').size

  end

end # class TestCodes


