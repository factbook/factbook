require 'hoe'
require './lib/factbook/version.rb'

Hoe.spec 'factbook' do

  self.version = Factbook::VERSION

  self.summary = 'factbook - scripts for the world factbook (get open structured data e.g JSON etc.)'
  self.description = summary

  self.urls = ['https://github.com/worlddb/factbook.ruby']

  self.author = 'Gerald Bauer'
  self.email = 'openmundi@googlegroups.com'

  # switch extension to .markdown for gihub formatting
  self.readme_file = 'README.md'
  self.history_file = 'HISTORY.md'

  self.extra_deps = [
    ['logutils' ],
    ['fetcher'],
    ['nokogiri']
  ]

  self.licenses = ['Public Domain']

  self.spec_extras = {
   :required_ruby_version => '>= 1.9.2'
  }

end


=begin
# errors to fix:
saving a copy to europe/li-liechtenstein.html for debugging
  found section 0 @ 38
  found section 1 @ 1882
  found section 2 @ 13160
  found section 3 @ 29355
  found section 4 @ 46010
*** error: section not found -- <div id="CollapsiblePanel1_Energy"
  found section 6 @ 64725

aving a copy to europe/mc-monaco.html for debugging
  found section 0 @ 38
  found section 1 @ 1446
  found section 2 @ 12736
  found section 3 @ 31192
  found section 4 @ 47762
*** error: section not found -- <div id="CollapsiblePanel1_Energy"

saving a copy to europe/sm-san-marino.html for debugging
  found section 0 @ 38
  found section 1 @ 1379
  found section 2 @ 12243
  found section 3 @ 27349
  found section 4 @ 46949
*** error: section not found -- <div id="CollapsiblePanel1_Energy"

saving a copy to europe/va-vatican-city.html for debugging
  found section 0 @ 38
  found section 1 @ 2000
  found section 2 @ 13093
  found section 3 @ 19912
  found section 4 @ 37264
*** error: section not found -- <div id="CollapsiblePanel1_Energy"
  found section 6 @ 44353
*** error: section not found -- <div id="CollapsiblePanel1_Trans"

saving a copy to pacific/mh-marshall-islands.html for debugging
  found section 0 @ 38
  found section 1 @ 1414
  found section 2 @ 13404
  found section 3 @ 34854
  found section 4 @ 52734
*** error: section not found -- <div id="CollapsiblePanel1_Energy"

=end



desc 'generate json for factbook.json repo'
task :genjson do
  require 'factbook'
  require 'fileutils'

  countries = [
=begin
     ['xx', 'world' ],     ## special code for the world
     ['ee', 'europe/eu-european-union'],  ## special code for the european union
     ['al', 'europe/al-albania' ],
     ['an', 'europe/ad-andorra' ],
     ['am', 'europe/am-armenia' ],
     ['au', 'europe/at-austria' ],
     ['aj', 'europe/az-azerbaijan' ],
     ['bo', 'europe/by-belarus' ],
     ['be', 'europe/be-belgium' ],
     ['bk', 'europe/ba-bosnia-n-herzegovina' ],
     ['bu', 'europe/bg-bulgaria' ],
     ['hr', 'europe/hr-croatia' ],
     ['cy', 'europe/cy-cyprus' ],
     ['ez', 'europe/cz-czech-republic' ],
     ['da', 'europe/dk-denmark' ],
     ['en', 'europe/ee-estonia' ], 
     ['fi', 'europe/fi-finland' ],
     ['fr', 'europe/fr-france' ],
     ['gg', 'europe/ge-georgia' ],
     ['gm', 'europe/de-germany' ],
     ['uk', 'europe/gb-great-britain' ],
     ['gr', 'europe/gr-greece' ],
     ['hu', 'europe/hu-hungary' ],
     ['ic', 'europe/is-iceland' ],
     ['ei', 'europe/ie-ireland' ],
     ['it', 'europe/it-italy' ],
     ['lg',   'europe/lv-latvia' ],
#     ['ls',   'europe/li-liechtenstein' ],
     ['lh',   'europe/lt-lithuania' ],
     ['lu',   'europe/lu-luxembourg' ],
     ['mk',   'europe/mk-macedonia' ],
     ['mt',   'europe/mt-malta' ],
     ['md',   'europe/md-moldova' ],
#     ['mn',   'europe/mc-monaco' ],
     ['mj',   'europe/me-montenegro' ],
     ['nl',   'europe/nl-netherlands' ],
     ['no',   'europe/no-norway' ],
     ['pl',   'europe/pl-poland' ],
     ['po',   'europe/pt-portugal' ],
     ['ro',   'europe/ro-romania' ],
     ['rs',   'europe/ru-russia' ],
#     ['sm',   'europe/sm-san-marino' ],
     ['ri',   'europe/rs-serbia' ],
     ['lo',   'europe/sk-slovakia' ],
     ['si',   'europe/si-slovenia' ],
     ['sp',   'europe/es-spain' ],
     ['sw',   'europe/se-sweden' ],
     ['sz',   'europe/ch-switzerland' ],
     ['tu',   'europe/tr-turkey' ],
     ['up',   'europe/ua-ukraine' ],
#     ['vt',   'europe/va-vatican-city' ],

     ['us',   'north-america/us-united-states' ],
     ['mx',   'north-america/mx-mexico' ],
     ['ca',   'north-america/ca-canada' ],

     ['bh',   'central-america/bz-belize' ],
     ['cs',   'central-america/cr-costa-rica' ],
     ['es',   'central-america/sv-el-salvador' ],
     ['gt',   'central-america/gt-guatemala' ],
     ['ho',   'central-america/hn-honduras' ],
     ['nu',   'central-america/ni-nicaragua' ],
     ['pm',   'central-america/pa-panama' ],

     ['ar',   'south-america/ar-argentina' ],
     ['bl',   'south-america/bo-bolivia' ],
     ['br', 'south-america/br-brazil' ],
     ['ci',   'south-america/cl-chile' ],
     ['co',   'south-america/co-colombia' ],
     ['ec',   'south-america/ec-ecuador' ],
     ['gy',   'south-america/gy-guyana' ],
     ['pa',   'south-america/py-paraguay' ],
     ['pe',   'south-america/pe-peru' ],
     ['ns',   'south-america/sr-suriname' ],
     ['uy',   'south-america/uy-uruguay' ],
     ['ve',   'south-america/ve-venezuela' ],

     ['ac',   'caribbean/ag-antigua-n-barbuda' ],
     ['bf',   'caribbean/bs-bahamas' ],
     ['bb',   'caribbean/bb-barbados' ],
     ['cu',   'caribbean/cu-cuba' ],
     ['do',   'caribbean/dm-dominica' ],
     ['dr',   'caribbean/do-dominican-republic' ],
     ['gj',   'caribbean/gd-grenada' ],
     ['ha',   'caribbean/ht-haiti' ],
     ['jm',   'caribbean/jm-jamaica' ],
     ['sc',   'caribbean/kn-saint-kitts-n-nevis' ],
     ['st',   'caribbean/lc-saint-lucia' ],
     ['vc',   'caribbean/vc-saint-vincent-n-the-grenadines' ],
     ['td',   'caribbean/tt-trinidad-n-tobago' ],

     ['ag',   'africa/dz-algeria' ],
     ['ao',   'africa/ao-angola' ],
     ['bn',   'africa/bj-benin' ],
     ['bc',   'africa/bw-botswana' ],

     ['ba',   'middle-east/bh-bahrain' ],
     ['ir',   'middle-east/ir-iran' ],
     ['iz',   'middle-east/iq-iraq' ],
     ['is',   'middle-east/il-israel' ],
     ['jo',   'middle-east/jo-jordan' ],

     ['af',   'asia/af-afghanistan' ],
     ['bg',   'asia/bd-bangladesh' ],
     ['bt',   'asia/bt-bhutan' ],
     ['bx',   'asia/bn-brunei' ],
     ['cb',   'asia/kh-cambodia' ],
     ['ch',   'asia/cn-china' ],
     ['in',   'asia/in-india' ],

     ['as',   'pacific/au-australia' ],
     ['fj',   'pacific/fj-fiji' ],
     ['kr',   'pacific/ki-kiribati' ],
#     ['rm',   'pacific/mh-marshall-islands' ],
=end

     ['fm',   'pacific/fm-micronesia' ],
     ['nr',   'pacific/nr-nauru' ],
     ['nz',   'pacific/nz-new-zealand' ],

=begin
=end
  ]

  countries.each do |country|
     gen_json_for( country )
  end
end


def gen_json_for( country )

  country_code = country[0]
  country_path = country[1]

  path_html = "tmp/html/#{country_path}.html"
  path_json = "tmp/json/#{country_path}.json"

  ## make sure path exist
  FileUtils.mkdir_p( File.dirname( path_html ) )
  FileUtils.mkdir_p( File.dirname( path_json ) )


  page = Factbook::Page.new( country_code )

  ## print first 600 chars
  pp page.html[0..600]

  ## save for debuging
  
  puts "saving a copy to #{country_path}.html for debugging"
  File.open( path_html, 'w') do |f|
      f.write( page.html )
  end

  h = page.data
  ## pp h

  ### save to json
  puts "saving a copy to #{country_path}.json for debugging"
  File.open( path_json, 'w') do |f|
    f.write( JSON.pretty_generate( h ) )
  end
end

