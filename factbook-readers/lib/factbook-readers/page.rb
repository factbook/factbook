
module Factbook


class Page
  include LogUtils::Logging

  attr_reader :sects    ## "structured" access e.g. sects/subsects/etc.
  attr_reader :info     ##  meta info e.g. country_code, country_name, region_name, last_updated, etc.
  attr_reader :data     ## "plain" access with vanilla hash


  ## standard version  (note: requires https)
  SITE_BASE = 'https://www.cia.gov/library/publications/the-world-factbook/geos/{code}.html'


  def self.parse( html )   ## parse html from string
    new( html: html )
  end

  def self.read( path )
    html = File.open( path, 'r:utf-8' ) { |f| f.read }
    new( html: html )
  end

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

  ## some convenience alias(es)
  class << self
    alias_method :read_html,  :read
    alias_method :parse_html, :parse
  end


  def initialize( code=nil,
                  json: nil,
                  html: nil,
                  cache: false,
                  info: nil )
    if json
       ## note: assumes json is (still) a string/text
       ##        (NOT yet parsed to structured data)
      b = JsonBuilder.new( json )
    else  ## assume html
      if html
        ## for debugging and testing allow "custom" passed-in html page
      else
        ## allow passing in code struct too - just use/pluck two-letter code from struct !!!
        code = code.code   if code.is_a?( Codes::Code )

        raise ArgumentError, "two letter code (e.g. au) required to download page & build page url"   if code.nil?
        url = SITE_BASE.sub( '{code}', code )

        html = if cache && Webcache.exist?( url )
                   Webcache.read( url )  ## for debugging - read from cache
               else
                   download_page( url )
               end
      end
      b = Builder.new( html )
    end

    @sects = b.sects
    @info  = b.info

    ## todo/fix/quick hack:
    ##  check for info opts - lets you overwrite page info
    ##  -- use proper header to setup page info - why, why not??
    @info = info    if info


    @data = {}
    @sects.each do |sect|
      @data[ sect.title ] = sect.data
    end
  end


  def to_json( minify: false )  ## convenience helper for data.to_json; note: pretty print by default!
    if minify
      data.to_json
    else ## note: pretty print by default!
      JSON.pretty_generate( data )
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


private
  def download_page( url )
    response = Webget.page( url )

    ## note: exit on get / fetch error - do NOT continue for now - why? why not?
    exit 1   if response.status.nok?    ## e.g.  HTTP status code != 200


    response.text
  end
end # class Page
end # module Factbook
