###
#  to run use
#     ruby -I ./lib -I ./test test/test_download.rb


require 'helper'


class TestDownload < MiniTest::Test

  def test_pages

    ['au','be'].each do |code|

      page = Factbook::Page.download( code, cache: true )

      File.open( "./tmp/#{code}.debug.json", 'w:utf-8' ) do |f|
        f.write JSON.pretty_generate( page.to_h )
      end
    end

    assert true    ## assume everthing ok
  end


end # class TestDownload

