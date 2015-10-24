# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_comparisons.rb


require 'helper'


class TestComparisons < MiniTest::Test

  def test_comparisons
    assert_equal 74, Factbook::COMPARISONS.size
    assert_equal 74, Factbook.comparisons.size 
    assert_equal 74, Factbook.comparisons.to_a.size                    
  end

end # class TestComparisons
