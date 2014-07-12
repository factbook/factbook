# encoding: utf-8


require 'helper'


class TestJson < MiniTest::Unit::TestCase

  def setup
    Dir.mkdir( 'tmp' )  unless Dir.exists?( 'tmp' )
  end

  def test_json
     gen_json_for( 'au')
     gen_json_for( 'be')
     gen_json_for( 'br')
     gen_json_for( 'mx')
  end

  def gen_json_for( code )
    page = Factbook::Page.new( code )    
    page.html = File.read( "#{Factbook.root}/test/data/countrytemplate_#{code}.html" )

    ## print first 600 chars
    pp page.html[0..600]

    ## save for debuging
    
    puts "saving a copy to #{code}.html for debugging"
    File.open( "tmp/#{code}.html", 'w') do |f|
      f.write( page.html )
    end

    h = page.data
    pp h
    
    ### save to json
    puts "saving a copy to #{code}.json for debugging"
    File.open( "tmp/#{code}.json", 'w') do |f|
      f.write( JSON.pretty_generate( h ) )
    end
  end


end # class TestJson
