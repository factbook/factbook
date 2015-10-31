# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_builder.rb


require 'helper'


##
## use/fix: ASCII-8BIT (e.g.keep as is)


class TestBuilder < MiniTest::Test

  def test_build
    
    ['au','be'].each do |code|
       ## use/fix: ASCII-8BIT (e.g.keep as is) -???
       ## fix/todo: use ASCII8BIT/binary reader ??
      b = Factbook::Builder.from_file( "#{Factbook.root}/test/data/src/#{code}.html" )
      pp b.sects

      File.open( "./tmp/#{code}.debug.html", 'w' ) do |f|
        f.write b.html_debug
      end
    end

    assert true    ## assume everthing ok
  end


end # class TestBuilder

