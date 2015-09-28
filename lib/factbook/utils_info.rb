# encoding: utf-8

module Factbook
  module Utils

#######
## find meta data (about page info)


#### e.g. Page last updated on September 16, 2015

MONTH_EN_TO_S={
  'January'   => '1',
  'February'  => '2',
  'March'     => '3',
  'April'     => '4',
  'May'       => '5',
  'June'      => '6',
  'July'      => '7',
  'August'    => '8',
  'September' => '9',
  'October'   => '10',
  'November'  => '11',
  'December'  => '12'
}

PAGE_LAST_UPDATED_REGEX = /
                           Page \s last \s updated \s on \s
                            (?<month_en>[a-z]+) \s
                            (?<day>\d{1,2}), \s
                            (?<year>\d{4})
                          /imx

def find_page_last_updated( html )
  m = PAGE_LAST_UPDATED_REGEX.match( html )
  if m
    pp m
    month_en = m[:month_en]
    day      = m[:day]
    year     = m[:year]
    puts "** bingo - month #{month_en}, day #{day}, year #{year}"
    
    month = MONTH_EN_TO_S[ month_en ]
    date_str = "#{year}-#{month}-#{day}"
    pp date_str
    date = Date.strptime( date_str, '%Y-%m-%d' )
    date
  else
    nil
  end
end

##
## e.g. regioncode="eur" 
##      countrycode="au"  
##      countryname="Austria" 
##      flagsubfield="" 
##      countryaffiliation=""
##      flagdescription="" 
##      flagdescriptionnote="" 
##      region="Europe" 
##
##   note: countryaffiliation may be empty



COUNTRY_INFO_REGEX = /
             regioncode=(?<q1>"|')(?<region_code>.+?)\k<q1>
               \s+
             countrycode=(?<q2>"|')(?<country_code>.+?)\k<q2>       ## is k<3> backref
               \s+  
              countryname=(?<q3>"|')(?<country>.+?)\k<q3>
               \s+
                [^>]+?  ## allow any attribs (note: non-greedy)
              countryaffiliation=(?<q4>"|')(?<affiliation>.*?)\k<q4>     ## note: might be empty
               \s+
                [^>]+?  ## allow any attribs (note: non-greedy)
              region=(?<q5>"|')(?<region>.+?)\k<q5>    ## check world - might be empty ?? or for ocean ??
           /imx

CountryInfo = Struct.new( :country_code,
                          :country_name,
                          :country_affiliation,
                          :region_code,
                          :region_name )

def find_country_info( html )
  m = COUNTRY_INFO_REGEX.match( html )
  if m
    pp m
    rec = CountryInfo.new

    rec.country_code        = m[:country_code]
    rec.country_name        = m[:country]
    rec.country_affiliation = m[:affiliation]
    rec.region_code         = m[:region_code]
    rec.region_name         = m[:region]
    
    puts "** bingo - region_code >#{rec.region_code}<, region_name >#{rec.region_name}<, " +
                   "country_code >#{rec.country_code}<, country_name >#{rec.country_name}<, " +
                   "country_affiliation >#{rec.country_affiliation}<"
    rec
  else
    nil   ## or return empty struct with nils/empty strings - why?? why not??
  end
end


  end   # module Utils
end     # module Factbook
