
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

    if opts[:json]
      json = opts[:json]    ## note: json is (still) a string/text (NOT yet parsed to structured data)
      b = JsonBuilder.from_string( json )
    else  ## assume html
      if opts[:html]    ## note: expects ASCII-7BIT/BINARY encoding
         ## for debugging and testing allow "custom" passed-in html page
        html = opts[:html]
      else
        url_string =  SITE_BASE.gsub( '{code}', code )
        ## note: expects ASCII-7BIT/BINARY encoding

        ## html = fetch_page( url_string )   ## use PageFetcher class - why?? why not??
        html = Webcache.read( url_string )
      end
      b = Builder.from_string( html )
    end

    @sects = b.sects
    @info  = b.info

    ## todo/fix/quick hack:
    ##  check for info opts hash entry - lets you overwrite page info
    ##  -- use proper header to setup page info - why, why not??
    if opts[:info]
      info  = opts[:info]
      @info = info
    end

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

  ATTRIBUTES.each do |attrib|
    ## e.g.
    ##    def background()  data['Introduction']['Background']['text']; end
    ##    def location()    data['Geography']['Location']['text'];      end
    ##    etc.
    if attrib.path.size == 1
      define_method attrib.name.to_sym do
        @data.fetch( attrib.category, {} ).
              fetch( attrib.path[0], {} )['text']
      end
    else  ## assume size 2 for now
      define_method attrib.name.to_sym do
        @data.fetch( attrib.category, {} ).
              fetch( attrib.path[0], {} ).
              fetch( attrib.path[1], {} )['text']
      end
    end
  end


private
  def fetch_page( url )
    response = Webget.page( url )

    ## note: exit on get / fetch error - do NOT continue for now - why? why not?
    exit 1   if response.status.nok?    ## e.g.  HTTP status code != 200


    response.text
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
end # module Factbook
