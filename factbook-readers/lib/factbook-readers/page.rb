
module Factbook


class Page
  include LogUtils::Logging

  attr_reader :profile    ## "structured" access e.g. sects/subsects/etc.


  ## standard version  (note: requires https)
  SITE_BASE = 'https://www.cia.gov/library/publications/the-world-factbook/geos/{code}.html'


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
      b = JsonBuilder.new( json )
    else  ## assume "raw" json dataset
        ## allow passing in code struct too - just use/pluck two-letter code from struct !!!
        code = code.code   if code.is_a?( Codes::Code )

        raise ArgumentError, "two letter code (e.g. au) required to download page & build page url"   if code.nil?
        url = SITE_BASE.sub( '{code}', code )

        html = if cache && Webcache.exist?( url )
                   Webcache.read( url )  ## for debugging - read from cache
               else
                   download_page( url )
               end
      b = Builder.new( html )
    end

    @profile = b.profile
    ## @info  = b.info

    ## todo/fix/quick hack:
    ##  check for info opts - lets you overwrite page info
    ##  -- use proper header to setup page info - why, why not??
    ## @info = info    if info
  end


  def [](key)  ### convenience shortcut
    # lets you use
    #   page['geo']
    #   instead of
    #   page.profile['geo']

    ##  fix: use delegate data, [] from forwardable lib - why?? why not??
    @profile[key]
  end


  def to_json( minify: false )  ## convenience helper for data.to_json; note: pretty print by default!
    @profile.to_json( minify: minify )
  end




private
  def download_page( url )
    response = Webget.page( url )

    ## note: exit on get / fetch error - do NOT continue for now - why? why not?
    exit 1   if response.status.nok?    ## e.g.  HTTP status code != 200


    response.text
  end
end # class Page
end # module Factbook
