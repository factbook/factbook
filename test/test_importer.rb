# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_importer.rb

require 'helper'


class TestImporter < MiniTest::Test

  def setup_in_memory_db
    # Database Setup & Config
    ActiveRecord::Base.logger = Logger.new( STDOUT )
    ## ActiveRecord::Base.colorize_logging = false  - no longer exists - check new api/config setting?

    ActiveRecord::Base.establish_connection( adapter:  'sqlite3',
                                             database: ':memory:' )

    ## build schema
    Factbook::CreateDb.new.up
  end

  def read_test_page( code )
    html = File.read( "#{Factbook.root}/test/data/src/#{code}.html" )
    page = Factbook::Page.new( code, html: html )
    page
  end


  def to_be_done_test_au_fix_me
    page = read_test_page( 'au' )  # use builtin test page (do NOT fetch via internet)

    setup_in_memory_db()

    im = Factbook::Importer.new
    im.import( page )

    rec = Factbook::Fact.find_by! code: 'au'

    ###########
    ## Geography
    assert_equal 83_871,    rec.area
    assert_equal 82_445,    rec.area_land
    assert_equal  1_426,    rec.area_water

    ###################
    ## People and Society
    assert_equal 8_665_550, rec.population
    assert_equal 0.55,      rec.population_growth
    assert_equal 9.41,      rec.birth_rate
    assert_equal 9.42,      rec.death_rate
    assert_equal 5.56,      rec.migration_rate
  end

end # class TestImporter
