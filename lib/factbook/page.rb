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
   'Geography'    => [[:area,             'Area', 'total'],    ## convert to number -- why? why not??
                      [:area_land,        'Area', 'land' ],
                      [:area_water,       'Area', 'water'],
                      [:area_note,        'Area', 'note' ],
                      [:area_comparative, 'Area - comparative'],
                      [:climate,          'Climate'],
                      [:terrain,          'Terrain'],
                      [:elevation_lowest, 'Elevation extremes', 'lowest point'],
                      [:elevation_highest,'Elevation extremes', 'highest point'],
                      [:resources,        'Natural resources']],
  'People and Society' => [[:languages,         'Languages' ],
                           [:religions,         'Religions' ],
                           [:population,        'Population' ],
                           [:population_growth, 'Population growth rate' ],
                           [:birth_rate,        'Birth rate' ],
                           [:death_rate,        'Death rate' ],
                           [:migration_rate,    'Net migration rate' ],
                           [:major_cities,      'Major urban areas - population' ]],
  }
  
  ATTRIBUTES.each do |section_title, attribs|
    attribs.each do |attrib|
      ## e.g.
      ##    def background()  data['Introduction']['Background']['text']; end  
      ##    def location()    data['Geography']['Location']['text'];      end
      ##    etc.
      if attrib.size == 2
        define_method attrib[0] do
          @data[section_title][attrib[1]]['text']
        end
      else  ## assume size 3 for now
        define_method attrib[0] do
          @data[section_title][attrib[1]][attrib[2]]['text']
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
