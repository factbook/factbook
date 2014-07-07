# encoding: utf-8


require 'helper'


class TestPage < MiniTest::Unit::TestCase

  def test_mx
    page = Factbook::Page.new( 'mx' )
    t = page.fetch
    
    ## print first 600 chars
    pp t[0..600]
  end


end # class TestPage
