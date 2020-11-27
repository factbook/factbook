###
#  to run use
#     ruby -I ./lib -I ./test test/test_sanitizer.rb


require 'helper'


class TestSanitizer < MiniTest::Test

  def test_sanitize

    ## austria (au)
    ## algeria (ag)
    ## belgium (be)
    ## ['au'].each do |cnty|
    ['au','ag','be'].each do |cnty|

      html_original = File.read( "#{Factbook.root}/test/data/src/#{cnty}.html", 'r:utf-8' ) { |f| r.read }

      html, info, errors = Factbook::Sanitizer.new.sanitize( html_original )

      File.open( "./tmp/#{cnty}.profile.html", 'w' ) do |f|
        f.write "** info:\n"
        f.write info.inspect + "\n\n"
        f.write "** errors:\n"
        f.write errors.inspect + "\n\n"
        f.write "** html:\n"
        f.write html
      end
    end

    assert true    ## assume everthing ok
  end

end # class TestSanitizer
