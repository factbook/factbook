###
#  to run use
#     ruby -I ./lib -I ./test test/test_normalize.rb


require 'helper'


class TestNormalizer < MiniTest::Test

  include Factbook::NormalizeHelper

  def test_normalize
    assert_equal 'border countries', normalize_title( 'border countries:'  )
    assert_equal 'border countries', normalize_title( 'border countries: ' )
    assert_equal 'border countries', normalize_title( 'border countries (8):' )
    assert_equal 'border countries', normalize_title( 'border countries (10): ' )
  end

end # class TestNormalizer

