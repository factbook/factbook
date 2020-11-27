# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_attribs_def.rb

require 'helper'


class TestAttribsDef < MiniTest::Test

  def test_attribs
    
    attribs = Factbook.attributes
    pp attribs
    
    assert true
  end

end # class TestAttribsDef
