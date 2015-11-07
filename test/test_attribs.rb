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

  def read_test_page_from_json( code )
    json = File.read( "#{Factbook.root}/test/data/json/#{code}.json" )
    page = Factbook::Page.new( code, json: json )
    page    
  end


  def test_au_from_html
    page = read_test_page( 'au' )  # note: use builtin test page (do NOT fetch via internet)
    
    assert_page_au( page )
  end

  def test_au_from_json
    page = read_test_page_from_json( 'au' )
    
    assert_page_au( page )
  end

private  
  def assert_page_au( page )
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


    ####################
    ## Economy
    assert_equal page.economy_overview,   "Austria, with its well-developed market economy, skilled labor force, and high standard of living, is closely tied to other EU economies, especially Germany's. Its economy features a large service sector, a relatively sound industrial sector, and a small, but highly developed agricultural sector. Economic growth was anemic at less than 0.5% in 2013 and 2014, and growth in 2015 is not expected to exceed 0.5%. Austria’s 5.6% unemployment rate, while low by European standards, is at an historic high for Austria. Without extensive vocational training programs and generous early retirement, the unemployment rate would be even higher. Public finances have not stabilized even after a 2012 austerity package of expenditure cuts and new revenues. On the contrary, in 2014, the government created a “bad bank” for the troubled nationalized “Hypo Alpe Adria” bank, pushing the budget deficit up by 0.9% of GDP to 2.4% and public debt to 84.5% of the GDP. Although Austria's fiscal position compares favorably with other euro-zone countries, it faces several external risks, such as Austrian banks' continued exposure to Central and Eastern Europe, repercussions from the Hypo Alpe Adria bank collapse, political and economic uncertainties caused by the European sovereign debt crisis, the current crisis in Russia/Ukraine, the recent appreciation of the Swiss Franc, and political developments in Hungary."
    assert_equal page.gdp_ppp,            "$395.5 billion (2014 est.) ++ $394.1 billion (2013 est.) ++ $393.3 billion (2012 est.)"
    assert_equal page.gdp_ppp_note,       "data are in 2014 US dollars"
    assert_equal page.gdp,                 "$437.1 billion (2014 est.)" 
    assert_equal page.gdp_growth,          "0.3% (2014 est.) ++ 0.2% (2013 est.) ++ 0.9% (2012 est.)" 
    assert_equal page.gdp_ppp_capita,      "$46,400 (2014 est.) ++ $46,300 (2013 est.) ++ $46,200 (2012 est.)" 
    assert_equal page.gdp_ppp_capita_note, "data are in 2014 US dollars" 
    assert_equal page.saving,              "25% of GDP (2014 est.) ++ 23.9% of GDP (2013 est.) ++ 26.3% of GDP (2012 est.)"   
  end

end # class TestAttribs
