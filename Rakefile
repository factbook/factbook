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



desc 'generate json for factbook.json repo'
task :genjson do
  require 'factbook'

  countries = [
     ['xx', 'world' ],     ## special code for the world

=begin
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
     ['ls',   'europe/li-liechtenstein' ],
     ['lh',   'europe/lt-lithuania' ],
     ['lu',   'europe/lu-luxembourg' ],
     ['mk',   'europe/mk-macedonia' ],
     ['mt',   'europe/mt-malta' ],
     ['md',   'europe/md-moldova' ],
     ['mn',   'europe/mc-monaco' ],
     ['mj',   'europe/me-montenegro' ],
     ['nl',   'europe/nl-netherlands' ],
     ['no',   'europe/no-norway' ],
     ['pl',   'europe/pl-poland' ],
     ['po',   'europe/pt-portugal' ],
     ['ro',   'europe/ro-romania' ],
     ['rs',   'europe/ru-russia' ],
     ['sm',   'europe/sm-san-marino' ],
     ['ri',   'europe/rs-serbia' ],
     ['lo',   'europe/sk-slovakia' ],
     ['si',   'europe/si-slovenia' ],
     ['sp',   'europe/es-spain' ],
     ['sw',   'europe/se-sweden' ],
     ['sz',   'europe/ch-switzerland' ],
     ['tu',   'europe/tr-turkey' ],
     ['up',   'europe/ua-ukraine' ],
     ['vt',   'europe/va-vatican-city' ],

     ['ca',   'north-america/ca-canada' ],
     ['us',   'north-america/us-united-states' ],
     ['mx',   'north-america/mx-mexico' ],

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

     ['bh',   'central-america/bz-belize' ],
     ['cs',   'central-america/cr-costa-rica' ],
     ['es',   'central-america/sv-el-salvador' ],
     ['gt',   'central-america/gt-guatemala' ],
     ['ho',   'central-america/hn-honduras' ],
     ['nu',   'central-america/ni-nicaragua' ],
     ['pm',   'central-america/pa-panama' ],

     ['ar',   'south-america/ar-argentina' ],
     ['bl',   'south-america/bo-bolivia' ],
     ['br',   'south-america/br-brazil' ],
     ['ci',   'south-america/cl-chile' ],
     ['co',   'south-america/co-colombia' ],
     ['ec',   'south-america/ec-ecuador' ],
     ['gy',   'south-america/gy-guyana' ],
     ['pa',   'south-america/py-paraguay' ],
     ['pe',   'south-america/pe-peru' ],
     ['ns',   'south-america/sr-suriname' ],
     ['uy',   'south-america/uy-uruguay' ],
     ['ve',   'south-america/ve-venezuela' ],

     ['ag',   'africa/dz-algeria' ],
     ['ao',   'africa/ao-angola' ],
     ['bn',   'africa/bj-benin' ],
     ['bc',   'africa/bw-botswana' ],
     ['uv',   'africa/bf-burkina-faso' ],
     ['by',   'africa/bi-burundi' ],
     ['cm',   'africa/cm-cameroon' ],
     ['cv',   'africa/cv-cape-verde' ],
     ['ct',   'africa/cf-central-african-republic' ],
     ['cd',   'africa/td-chad' ],
     ['cn',   'africa/km-comoros' ],
     ['cf',   'africa/cg-congo' ],
     ['cg',   'africa/cd-congo-dr' ],
     ['iv',   'africa/ci-cote-d-ivoire' ],
     ['dj',   'africa/dj-djibouti' ],
     ['eg',   'africa/eg-egypt' ],
     ['ek',   'africa/gq-equatorial-guinea' ],
     ['er',   'africa/er-eritrea' ],
     ['et',   'africa/et-ethiopia' ],
     ['gb',   'africa/ga-gabon' ],
     ['ga',   'africa/gm-gambia' ],
     ['gh',   'africa/gh-ghana' ],
     ['gv',   'africa/gn-guinea' ],
     ['pu',   'africa/gw-guinea-bissau' ],
     ['ke',   'africa/ke-kenya' ],
     ['lt',   'africa/ls-lesotho' ],
     ['li',   'africa/lr-liberia' ],
     ['ly',   'africa/ly-libya' ],
     ['ma',   'africa/mg-madagascar' ],
     ['mi',   'africa/mw-malawi' ],
     ['ml',   'africa/ml-mali' ],
     ['mr',   'africa/mr-mauritania' ],
     ['mp',   'africa/mu-mauritius' ],
     ['mo',   'africa/ma-morocco' ],
     ['mz',   'africa/mz-mozambique' ],
     ['wa',   'africa/na-namibia' ],
     ['ng',   'africa/ne-niger' ],
     ['ni',   'africa/ng-nigeria' ],
     ['rw',   'africa/rw-rwanda' ],
     ['tp',   'africa/st-st-sao-tome-n-principe' ],
     ['sg',   'africa/sn-senegal' ],
     ['se',   'africa/sc-seychelles' ],
     ['sl',   'africa/sl-sierra-leone' ],
     ['so',   'africa/so-somalia' ],
     ['sf',   'africa/za-south-africa' ],
     ['od',   'africa/ss-south-sudan' ],
     ['su',   'africa/sd-sudan' ],
     ['wz',   'africa/sz-swaziland' ],
     ['tz',   'africa/tz-tanzania' ],
     ['to',   'africa/tg-togo' ],
     ['ts',   'africa/tn-tunisia' ],
     ['ug',   'africa/ug-uganda' ],
     ['za',   'africa/zm-zambia' ],
     ['zi',   'africa/zw-zimbabwe' ],

     ['ba',   'middle-east/bh-bahrain' ],
     ['ir',   'middle-east/ir-iran' ],
     ['iz',   'middle-east/iq-iraq' ],
     ['is',   'middle-east/il-israel' ],
     ['jo',   'middle-east/jo-jordan' ],
     ['ku',   'middle-east/kw-kuwait' ],
     ['le',   'middle-east/lb-lebanon' ],
     ['mu',   'middle-east/om-oman' ],
###  ['??',   'middle-east/ps-palestine' ],  -- incl. gaza strip n west bank 
     ['qa',   'middle-east/qa-qatar' ],
     ['sa',   'middle-east/sa-saudi-arabia' ],
     ['sy',   'middle-east/sy-syria' ],
     ['ae',   'middle-east/ae-united-arab-emirates' ],
     ['ym',   'middle-east/ye-yemen' ],

     ['af',   'asia/af-afghanistan' ],
     ['bg',   'asia/bd-bangladesh' ],
     ['bt',   'asia/bt-bhutan' ],
     ['bx',   'asia/bn-brunei' ],
     ['cb',   'asia/kh-cambodia' ],
     ['ch',   'asia/cn-china' ],
     ['in',   'asia/in-india' ],
     ['id',   'asia/id-indonesia' ],
     ['ja',   'asia/jp-japan' ],
     ['kz',   'asia/kz-kazakhstan' ],
     ['kg',   'asia/kg-kyrgyzstan' ],
     ['la',   'asia/la-laos' ],
     ['my',   'asia/my-malaysia' ],
     ['mv',   'asia/mv-maldives' ],
     ['mg',   'asia/mn-mongolia' ],
     ['bm',   'asia/mm-myanmar' ],     ## still using Burma
     ['np',   'asia/np-nepal' ],
     ['kn',   'asia/kp-north-korea' ],
     ['pk',   'asia/pk-pakistan' ],
     ['rp',   'asia/ph-philippines' ],
     ['sn',   'asia/sg-singapore' ],
     ['ks',   'asia/kr-south-korea' ],
     ['ce',   'asia/lk-sri-lanka' ],
     ['tw',   'asia/tw-taiwan' ],
     ['ti',   'asia/tj-tajikistan' ],
     ['th',   'asia/th-thailand' ],
     ['tt',   'asia/tl-timor-leste' ],
     ['tx',   'asia/tm-turkmenistan' ],
     ['uz',   'asia/uz-uzbekistan' ],
     ['vm',   'asia/vn-vietnam' ],

     ['as',   'pacific/au-australia' ],
     ['fj',   'pacific/fj-fiji' ],
     ['kr',   'pacific/ki-kiribati' ],
     ['rm',   'pacific/mh-marshall-islands' ],
     ['fm',   'pacific/fm-micronesia' ],
     ['nr',   'pacific/nr-nauru' ],
     ['nz',   'pacific/nz-new-zealand' ],
     ['ps',   'pacific/pw-palau' ],
     ['pp',   'pacific/pg-papua-new-guinea' ],
     ['ws',   'pacific/ws-samoa' ],
     ['bp',   'pacific/sb-solomon-islands' ],
     ['tn',   'pacific/to-tonga' ],
     ['tv',   'pacific/tv-tuvalu' ],
     ['nh',   'pacific/vu-vanuatu' ],
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

  File.open( path_html, 'w') do |f|
      f.write( page.html )
  end

  h = page.data
  File.open( path_json, 'w') do |f|
    f.write( JSON.pretty_generate( h ) )
  end
end
