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

  attr_accessor :sects
  
  def initialize
    @sects = []
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
