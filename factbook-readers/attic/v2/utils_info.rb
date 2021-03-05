
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



##
#  examples (to match):
#    Page last updated on November 03, 2016
#    Page last updated on September 24, 2015

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


##  fallback: find "standalone" country coude
## e.g.
##  ccode='au'

COUNTRY_CODE_REGEX = /ccode='(?<cc>[a-z]+)'/

def find_country_code( html )
  m = COUNTRY_CODE_REGEX.match( html )
  if m
    pp m
    cc = m[:cc]
    puts "** bingo - country code #{cc}"
    cc
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



PAGE_INFO_REGEX = /
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


def find_page_info( html )
  m = PAGE_INFO_REGEX.match( html )
  if m
    pp m

    h = { country_code:        m[:country_code],
          country_name:        m[:country],
          country_affiliation: m[:affiliation],
          region_code:         m[:region_code],
          region_name:         m[:region] }

    puts "** bingo - #{h.inspect}"
    h    ## return hash w/ name-value pairs
  else
    nil   ## or return empty struct with nils/empty strings - why?? why not??
  end
end


  end   # module Utils
end     # module Factbook
