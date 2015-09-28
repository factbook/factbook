# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_builder.rb


require 'helper'


##
## use/fix: ASCII-8BIT (e.g.keep as is)


class TestBuilder < MiniTest::Test

  INPUT_DIR = "#{Factbook.root}/test/data/src"

  def test_au
    cc = 'au'
    b = Factbook::Builder.from_file( cc, input_dir: INPUT_DIR )

    File.open( "./tmp/#{cc}.debug.html", 'w' ) do |f|
      f.write b.html_debug
    end

    assert true    ## assume everthing ok
  end

  def xxx_test_be
    cc = 'be'
    b = Factbook::Builder.from_file( cc, input_dir: INPUT_DIR )

    assert true    ## assume everthing ok
  end


end # class TestBuilder

