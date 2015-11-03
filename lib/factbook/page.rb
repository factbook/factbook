# encoding: utf-8

module Factbook


## note:
##   some factbook pages with chrome (headers, footers, etc.)
##     are NOT valid utf-8, thus,
##     treat page as is (e.g. ASCII8BIT)
#
#   only convert to utf8 when header and footer got stripped

##
## be/benin:
##   Key Force or FC [Lazare S?xx?HOU?xx?TO]     -- two invalid byte code chars in Political parties and leaders:
#
##   in Western/Windows-1252  leads to  FC [Lazare SÈHOUÉTO];
#       Lazare Sèhouéto
#
#   looks good - use (assume) Windows-1252 ????

##
#   check for is ascii 7-bit ???  if yes -noworries
#     if not, log number of chars not using ascii 7-bit



class Page
  include LogUtils::Logging

  attr_reader :sects    ## "structured" access e.g. sects/subsects/etc.
  attr_reader :info     ##  meta info e.g. country_code, country_name, region_name, last_updated, etc.
  attr_reader :data     ## "plain" access with vanilla hash


  ## standard version  (note: requires https)
  SITE_BASE = 'https://www.cia.gov/library/publications/the-world-factbook/geos/{code}.html'

  def initialize( code, opts={} )
    ### keep code - why? why not??  (use page_info/info e.g. info.country_code??)
    
    if opts[:html]    ## note: expects ASCII-7BIT/BINARY encoding
       ## for debugging and testing allow "custom" passed-in html page
      html = opts[:html]
    else
      url_string =  SITE_BASE.gsub( '{code}', code )
      ## note: expects ASCII-7BIT/BINARY encoding
      html = fetch_page( url_string )   ## use PageFetcher class - why?? why not??
    end
    
    b = Builder.from_string( html )
    @sects = b.sects
    @info  = b.page_info    ## todo: change b.page_info to info too - why? why not??

    @data = {}    
    @sects.each do |sect|
      @data[ sect.title ] = sect.data
    end

    self  ## return self (check - not needed??)
  end


  def to_json( opts={} )  ## convenience helper for data.to_json; note: pretty print by default!
    if opts[:minify]
      data.to_json
    else
      ## was: -- opts[:pretty] || opts[:pp] 
      JSON.pretty_generate( data )   ## note: pretty print by default!
    end
  end


  def [](key)  ### convenience shortcut
    # lets you use
    #   page['geo']
    #   instead of
    #   page.data['geo']

    ##  fix: use delegate data, [] from forwardable lib - why?? why not??

    data[key]
  end

  ## add convenience (shortcut) accessors / attributes / fields / getters

  ATTRIBUTES = {
   'Introduction' => [[:background, 'Background' ]],
   'Geography'    => [[:location,         'Location'],
                      [:geo_coords,       'Geographic coordinates'],   ## just use coords - why, why not??
                      [:map_ref,          'Map references'],  ## just use map - why, why not??
                      [:area,             'Area', 'total'],
                      [:area_land,        'Area', 'land' ],
                      [:area_water,       'Area', 'water'],
                      [:area_note,        'Area', 'note' ],
                      [:area_comparative, 'Area - comparative'],
                      [:border_land,      'Land boundaries', 'total'],
                      [:border_countries, 'Land boundaries', 'border countries'],   ## todo/fix: remove count from key e.g. border countries (8)
                      [:coastline,        'Coastline'],   ## use border_water  - why, why not??
                      [:maritime_claims,  'Maritime claims'],
                      [:climate,          'Climate'],
                      [:terrain,          'Terrain'],
                      [:elevation_lowest, 'Elevation extremes', 'lowest point'],
                      [:elevation_highest,'Elevation extremes', 'highest point'],
                      [:resources,        'Natural resources'],
                      [:land_use_agriculture, 'Land use', 'agricultural land'],
                      [:land_use_forest,      'Land use', 'forest'],
                      [:land_use_other,       'Land use', 'other'],
                      [:land_irrigated,       'Irrigated land'],
                      [:water_renewable,      'Total renewable water resources'],
                      [:water_withdrawal,     'Freshwater withdrawal (domestic/industrial/agricultural)', 'total'],
                      [:water_withdrawal_capita, 'Freshwater withdrawal (domestic/industrial/agricultural)', 'per capita'],
                      [:natural_hazards,    'Natural hazards'],
                      [:environment_issues,          'Environment - current issues'],
                      [:environment_agreements,      'Environment - international agreements', 'party to'],
                      [:environment_agreements_note, 'Environment - international agreements', 'signed, but not ratified'],   ## use _ratified - why, why not??
                      [:geo_note,                    'Geography - note']],
  'People and Society' => [[:nationality,           'Nationality', 'noun'],
                           [:nationality_adjective, 'Nationality', 'adjective'],
                           [:ethnic_groups,     'Ethnic groups'],
                           [:languages,         'Languages' ],
                           [:religions,         'Religions' ],
                           [:population,        'Population' ],
                           [:age_0_14_yrs,          'Age structure', '0-14 years'],
                           [:age_15_24_yrs,         'Age structure', '15-24 years'],
                           [:age_25_54_yrs,         'Age structure', '25-54 years'],
                           [:age_55_64_yrs,         'Age structure', '55-64 years'],
                           [:age_65_plus_yrs,       'Age structure', '65 years and over'],
                           [:dependency_ratio,       'Dependency ratios', 'total'],
                           [:dependency_youth_ratio,  'Dependency ratios', 'youth dependency ratio'],
                           [:dependency_elderly_ratio, 'Dependency ratios', 'elderly dependency ratio'],
                           [:dependency_support_ratio, 'Dependency ratios', 'potential support ratio'],
                           [:median_age,        'Median age', 'total'],
                           [:median_age_male,   'Median age', 'male'],
                           [:median_age_female, 'Median age', 'female'],                           
                           [:population_growth, 'Population growth rate' ],
                           [:birth_rate,        'Birth rate' ],
                           [:death_rate,        'Death rate' ],
                           [:migration_rate,    'Net migration rate' ],
                           [:urbanization,      'Urbanization', 'urban population'],
                           [:urbanization_growth, 'Urbanization', 'rate of urbanization'], ## use _rate - why, why not??
                           [:major_cities,      'Major urban areas - population' ],
                           [:sex_ratio_birth,     'Sex ratio', 'at birth'],
                           [:sex_ratio_0_14_yrs,  'Sex ratio',  '0-14 years'],
                           [:sex_ratio_15_24_yrs, 'Sex ratio', '15-24 years'],
                           [:sex_ratio_25_54_yrs, 'Sex ratio', '25-54 years'],
                           [:sex_ratio_55_64_yrs, 'Sex ratio', '55-64 years'],
                           [:sex_ratio_65_plus_yrs, 'Sex ratio', '65 years and over'],
                           [:sex_ratio,             'Sex ratio', 'total population'],
                           [:infant_mortality,      'Infant mortality rate', 'total'],  ## add _rate - why, why not??
                           [:infant_mortality_male,   'Infant mortality rate', 'male'],
                           [:infant_mortality_female, 'Infant mortality rate', 'female'],
                           [:life_expectancy,         'Life expectancy at birth', 'total population'],
                           [:life_expectancy_male,    'Life expectancy at birth', 'male'],
                           [:life_expectancy_female,  'Life expectancy at birth', 'female'],
                           [:fertility,               'Total fertility rate'],
                           [:contraceptive_rate,      'Contraceptive prevalence rate'],
                           [:contraceptive_rate_note, 'Contraceptive prevalence rate', 'note'],
                           [:health_expenditures,     'Health expenditures'],  ## todo: change to health ??
                           [:density_physicians,      'Physicians density'],
                           [:density_hospital_bed,    'Hospital bed density'],
                           [:drinking_water_improved,   'Drinking water source', 'improved'],  ## todo:split into urban/rural/total ??
                           [:drinking_water_unimproved, 'Drinking water source', 'unimproved'],
                           [:sanitation_improved,         'Sanitation facility access', 'improved'],  ## todo:split into urban/rural/total ??
                           [:sanitation_unimproved,       'Sanitation facility access', 'unimproved'],
                           [:aids,                       'HIV/AIDS - adult prevalence rate'],
                           [:aids_people,                'HIV/AIDS - people living with HIV/AIDS'],
                           [:aids_deaths,                'HIV/AIDS - deaths'],
                           [:obesity,                    'Obesity - adult prevalence rate'],
                           [:education_expenditures,     'Education expenditures'],  ## change to education ??
                           ],  
  }
  
  ATTRIBUTES.each do |section_title, attribs|
    attribs.each do |attrib|
      ## e.g.
      ##    def background()  data['Introduction']['Background']['text']; end  
      ##    def location()    data['Geography']['Location']['text'];      end
      ##    etc.
      if attrib.size == 2
        define_method attrib[0] do
          @data.fetch( section_title, {} ).fetch( attrib[1], {} )['text']
        end
      else  ## assume size 3 for now
        define_method attrib[0] do
          @data.fetch( section_title, {} ).fetch( attrib[1], {} ).fetch( attrib[2], {} )['text']
        end
      end
    end
  end   


private
  def fetch_page( url_string )

    worker = Fetcher::Worker.new
    response = worker.get_response( url_string )

    if response.code == '200'
      t = response.body
      ###
      # NB: Net::HTTP will NOT set encoding UTF-8 etc.
      # will mostly be ASCII
       # - try to change encoding to UTF-8 ourselves
      logger.debug "t.encoding.name (before): #{t.encoding.name}"
      #####
      # NB: ASCII-8BIT == BINARY == Encoding Unknown; Raw Bytes Here
      t
    else
      logger.error "fetch HTTP - #{response.code} #{response.message}"
      ## todo/fix: raise http exception (see fetcher)  -- why? why not??
      fail "fetch HTTP - #{response.code} #{response.message}"
      nil
    end
  end


=begin
def self.from_url( cc, cn )
  html_ascii = PageFetcher.new.fetch( cc )
  self.new( cc, cn, html_ascii )
end

def self.from_file( cc, cn, opts={} )
  input_dir = opts[:input_dir] || '.'
  html_ascii = File.read( "#{input_dir}/#{cc}.html" )    ## fix/todo: use ASCII8BIT/binary reader
  self.new( cc, cn, html_ascii )
end
=end


end # class Page


=begin
class PageFetcher

def fetch( cc )
  worker = Fetcher::Worker.new
  factbook_base = 'https://www.cia.gov/library/publications/the-world-factbook/geos'

  res = worker.get_response( "#{factbook_base}/#{cc}.html" )

  # on error throw exception - why? why not??
  if res.code != '200'
    raise Fetcher::HttpError.new( res.code, res.message )
  end

  ###
  # Note: Net::HTTP will NOT set encoding UTF-8 etc.
  #   will be set to ASCII-8BIT == BINARY == Encoding Unknown; Raw Bytes Here
  html = res.body.to_s
end
end # PageFetcher
=end


end # module Factbook
