# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_normalize.rb


require 'helper'


class TestNormalizer < MiniTest::Test

  include Factbook::NormalizeHelper

  def test_normalize
    assert_equal 'border countries', normalize_category( 'border countries:'  )
    assert_equal 'border countries', normalize_category( 'border countries: ' )
    assert_equal 'border countries', normalize_category( 'border countries (8):' )
    assert_equal 'border countries', normalize_category( 'border countries (10): ' )
  end

end # class TestNormalizer

