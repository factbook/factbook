###
#  to run use
#     ruby -I ./lib -I ./test test/test_item_builder.rb


require 'helper'


class TestItemBuilder < MiniTest::Test

  def test_location

html =<<EOS
<div class=category_data>Central Europe, north of Italy and Slovenia</div>
EOS

    b = Factbook::ItemBuilder.new( html, 'Location' )
    b.read

    assert true    ## assume everthing ok
  end

  def test_area
html =<<EOS
<div><span class=category>total: </span><span class=category_data>83,871 sq km</span></div>
<div><span class=category>land: </span><span class=category_data>82,445 sq km</span></div>
<div><span class=category>water: </span><span class=category_data>1,426 sq km</span></div>
EOS

    b = Factbook::ItemBuilder.new( html, 'Area' )
    b.read

    assert true    ## assume everthing ok
  end

  def test_land_use
html =<<EOS
<div><span class=category>agricultural land: </span><span class=category_data>38.4%</span></div>
<div class=category_data>arable land 16.5%; permanent crops 0.8%; permanent pasture 21.1%</div>
<div><span class=category>forest: </span><span class=category_data>47.2%</span></div>
<div><span class=category>other: </span><span class=category_data>14.4% (2011 est.)</span></div>
EOS

    b = Factbook::ItemBuilder.new( html, 'Land use' )
    b.read

    assert true    ## assume everthing ok
  end

  def test_contraceptive_prevalence_rate
html =<<EOS
<div class=category_data>69.6%</div>
<div><span class=category>note: </span><span class=category_data>percent of women aged 18-46 (2008/09)</span></div>
EOS

    b = Factbook::ItemBuilder.new( html, 'Contraceptive Prevalence Rate' )
    b.read

    assert true    ## assume everthing ok
  end

  def test_drinking_water_source
html =<<EOS
<div><span class=category>improved: </span><span class=category_data></span></div>
<div class=category_data>urban: 100% of population</div>
<div class=category_data>rural: 100% of population</div>
<div class=category_data>total: 100% of population</div>
<div><span class=category>unimproved: </span><span class=category_data></span></div>
<div class=category_data>urban: 0% of population</div>
<div class=category_data>rural: 0% of population</div>
<div class=category_data>total: 0% of population (2015 est.)</div>
EOS

    b = Factbook::ItemBuilder.new( html, 'Drinking Water Source' )
    b.read

    assert true    ## assume everthing ok
  end

  def test_political_pressure_groups_and_leaders
html =<<EOS
<div class=category_data>Austrian Trade Union Federation or OeGB (nominally independent but primarily Social Democratic)</div>
<div class=category_data>Federal Economic Chamber (OeVP-dominated)</div>
<div class=category_data>Labor Chamber or AK (Social Democratic-leaning think tank)</div>
<div class=category_data>OeVP-oriented Association of Austrian Industrialists or IV</div>
<div class=category_data>Roman Catholic Church, including its chief lay organization, Catholic Action</div>
<div><span class=category>other: </span><span class=category_data>three composite leagues of the Austrian People's Party or OeVP representing business, labor, farmers, and other nongovernment organizations in the areas of environment and human rights</span></div>
EOS

    b = Factbook::ItemBuilder.new( html, 'Political pressure groups and leaders' )
    b.read

    assert true    ## assume everthing ok
  end

end # class TestItemBuilder

