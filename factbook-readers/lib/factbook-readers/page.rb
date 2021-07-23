
module Factbook


class Page
  include Logging

  attr_reader :info       ##  meta info e.g. country_code, country_name, region_name, updated, etc.

  ## standard version  (note: requires https)
  SITE_BASE = "https://www.cia.gov/the-world-factbook/geos/{code}.json"



  def self.parse_json( json )  ## parse json from string
    new( json: json )
  end

  def self.read_json( path )
    json = File.open( path, 'r:utf-8' ) { |f| f.read }
    new( json: json )
  end

  def self.download( code, cache: false )
    new( code, cache: cache )
  end



  def initialize( code=nil,
                  json: nil,
                  cache: false,
                  info: nil )
    if json
       ## note: assumes json is (still) a string/text
       ##        (NOT yet parsed to structured data)
      b = ProfileBuilder.new( json )
    else  ## assume "raw" json dataset
        ## allow passing in code struct too - just use/pluck two-letter code from struct !!!
        code = code.code   if code.is_a?( Codes::Code )

        raise ArgumentError, "two letter code (e.g. au) required to download page & build page url"   if code.nil?
        url = SITE_BASE.sub( '{code}', code )

        raw_data = if cache && Webcache.exist?( url )
                     text = Webcache.read( url )  ## for debugging - read from cache
                     JSON.parse( text )
                   else
                     download_data( url )
                   end

## meta info from raw date - example:
##   "name": "Aruba",
##   "code": "AA",
##   "region": "Central America",
##   "published": "2021-01-25 09:07:08 -0500",
##   "updated": "2021-01-22 14:38:14 -0500",
##
## note: published is NOT before updated (like an alias for created) BUT is often older/later than updated - why!?

        @info = PageInfo.new

        @info.country_code = raw_data['code'].downcase
        @info.country_name = raw_data['name']
        @info.region_name  = raw_data['region']

        ## note: just parse year,month,day for now (skip hours,minutes,etc.)
        @info.published    = Date.strptime( raw_data['published'], '%Y-%m-%d' )
        @info.updated      = Date.strptime( raw_data['updated'], '%Y-%m-%d' )

        data = convert_cia( raw_data )
        b = ProfileBuilder.new( data )
    end

    @profile = b.profile

    ## todo/fix/quick hack:
    ##  check for info opts - lets you overwrite page info
    ##  -- use proper header to setup page info - why, why not??
    @info = info    if info
  end



  ## convenience helpers - forward to profile
  def [](key)                   @profile[key]; end
  def to_h()                    @profile.to_h; end
  def to_html()                 @profile.to_html; end
  def to_json( minify: false )  @profile.to_json( minify: minify ); end
  def size()                    @profile.size; end


private
  def download_data( url )
    response = Webget.call( url )

    ## note: exit on get / fetch error - do NOT continue for now - why? why not?
    exit 1   if response.status.nok?    ## e.g.  HTTP status code != 200

    response.json
  end
end # class Page
end # module Factbook
