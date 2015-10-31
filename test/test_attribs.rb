# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_attribs.rb

require 'helper'


class TestAttribs < MiniTest::Test

  def read_test_page( code )
    html = File.read( "#{Factbook.root}/test/data/src/#{code}.html" )
    page = Factbook::Page.new( code, html: html )
    page    
  end

  def test_au
    page = read_test_page( 'au' )  # use builtin test page (do NOT fetch via internet)

    ########
    ## Introduction
    assert_equal page.background, "Once the center of power for the large Austro-Hungarian Empire, Austria was reduced to a small republic after its defeat in World War I. Following annexation by Nazi Germany in 1938 and subsequent occupation by the victorious Allies in 1945, Austria's status remained unclear for a decade. A State Treaty signed in 1955 ended the occupation, recognized Austria's independence, and forbade unification with Germany. A constitutional law that same year declared the country's \"perpetual neutrality\" as a condition for Soviet military withdrawal. The Soviet Union's collapse in 1991 and Austria's entry into the European Union in 1995 have altered the meaning of this neutrality. A prosperous, democratic country, Austria entered the EU Economic and Monetary Union in 1999."
    
    ###########
    ## Geography
    assert_equal page.area,       "83,871 sq km"       
    assert_equal page.area_land,  "82,445 sq km"
    assert_equal page.area_water, "1,426 sq km"
    assert_equal page.area_note,  nil
    assert_equal page.area_comparative, "about the size of South Carolina; slightly more than two-thirds the size of Pennsylvania"
    assert_equal page.climate,    "temperate; continental, cloudy; cold winters with frequent rain and some snow in lowlands and snow in mountains; moderate summers with occasional showers"  
    assert_equal page.terrain,    "mostly mountains (Alps) in the west and south; mostly flat or gently sloping along the eastern and northern margins"   
    assert_equal page.elevation_lowest,   "Neusiedler See 115 m"
    assert_equal page.elevation_highest,  "Grossglockner 3,798 m"
    assert_equal page.resources,  "oil, coal, lignite, timber, iron ore, copper, zinc, antimony, magnesite, tungsten, graphite, salt, hydropower"       

    ###################
    ## People and Society
    assert_equal page.languages,    "German (official nationwide) 88.6%, Turkish 2.3%, Serbian 2.2%, Croatian (official in Burgenland) 1.6%, other (includes Slovene, official in South Carinthia, and Hungarian, official in Burgenland) 5.3% (2001 est.)"
    assert_equal page.religions,    "Catholic 73.8% (includes Roman Catholic 73.6%, other Catholic .2%), Protestant 4.9%, Muslim 4.2%, Orthodox 2.2%, other 0.8% (includes other Christian), none 12%, unspecified 2% (2001 est.)"
    assert_equal page.population,   "8,665,550 (July 2015 est.)"  
    assert_equal page.population_growth, "0.55% (2015 est.)"
    assert_equal page.birth_rate,        "9.41 births/1,000 population (2015 est.)"
    assert_equal page.death_rate,        "9.42 deaths/1,000 population (2015 est.)"
    assert_equal page.migration_rate,    "5.56 migrant(s)/1,000 population (2015 est.)"
    assert_equal page.major_cities,      "VIENNA (capital) 1.753 million (2015)"

  end

end # class TestAttribs
