###
#  to run use
#     ruby -I ./lib -I ./test test/test_codes.rb


require 'helper'


class TestCodes < MiniTest::Test


  def test_codes
    codes = Factbook.codes

    assert_equal 260, codes.size
    assert_equal 260, codes.to_a.size


    assert_equal 195, codes.countries.size
    assert_equal  52, codes.dependencies.size
    assert_equal   5, codes.oceans.size
    assert_equal   1, codes.world.size
    assert_equal   2, codes.others.size
    assert_equal   5, codes.misc.size

    assert_equal   8, codes.dependencies_us.size


    assert_equal  55, codes.europe.size
    assert_equal   9, codes.south_asia.size
    assert_equal   6, codes.central_asia.size
    assert_equal  22, codes.east_n_souteast_asia.size
    assert_equal  19, codes.middle_east.size
    assert_equal  55, codes.africa.size
    assert_equal   7, codes.north_america.size
    assert_equal  33, codes.central_america_n_caribbean.size
    assert_equal  14, codes.south_america.size
    assert_equal  30, codes.australia_oceania.size
    assert_equal   4, codes.antartica.size
    assert_equal   5, codes.region('Oceans').size
    assert_equal   1, codes.region('World').size

    assert_equal  45, codes.countries.europe.size

    assert_equal  codes.category('Oceans').size, codes.region('Oceans').size
    assert_equal  codes.category('World').size,  codes.region('World').size


    assert_equal 260, codes.countries.size +
                      codes.others.size +
                      codes.dependencies.size +
                      codes.misc.size +
                      codes.oceans.size +
                      codes.world.size

    assert_equal 260, codes.europe.size +
                      codes.south_asia.size +
                      codes.central_asia.size +
                      codes.east_n_souteast_asia.size +
                      codes.middle_east.size +
                      codes.africa.size +
                      codes.north_america.size +
                      codes.central_america_n_caribbean.size +
                      codes.south_america.size +
                      codes.australia_oceania.size +
                      codes.antartica.size +
                      codes.region('Oceans').size +
                      codes.region('World').size
  end

  def test_region_slug
    codes = Factbook.codes

    #=> bx,Brunei,Countries,East & Southeast Asia
    bx = codes['bx']

    assert_equal 'Brunei', bx.name
    assert_equal 'East & Southeast Asia', bx.region
    assert_equal 'east-n-southeast-asia', bx.region_slug

    #=> ac,Antigua and Barbuda,Countries,Central America and Caribbean
    ac = codes['ac']

    assert_equal 'Antigua and Barbuda', ac.name
    assert_equal 'Central America and Caribbean', ac.region
    assert_equal 'central-america-n-caribbean',   ac.region_slug
  end
end # class TestCodes

