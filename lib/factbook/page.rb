# encoding: utf-8

module Factbook

  class Page

    include LogUtils::Logging
 
    SITE_BASE = 'https://www.cia.gov/library/publications/the-world-factbook/geos'

    def initialize( code )
      @code = code
    end

    def fetch
      uri_string = "#{SITE_BASE}/#{@code}.html"

      worker = Fetcher::Worker.new
      response = worker.get_response( uri_string )

      if response.code == '200'
        t = response.body
        ###
        # NB: Net::HTTP will NOT set encoding UTF-8 etc.
        # will mostly be ASCII
        # - try to change encoding to UTF-8 ourselves
        logger.debug "t.encoding.name (before): #{t.encoding.name}"
        #####
        # NB: ASCII-8BIT == BINARY == Encoding Unknown; Raw Bytes Here

        ## NB:
        # for now "hardcoded" to utf8 - what else can we do?
        # - note: force_encoding will NOT change the chars only change the assumed encoding w/o translation
        t = t.force_encoding( Encoding::UTF_8 )
        logger.debug "t.encoding.name (after): #{t.encoding.name}"
        ## pp t
        t
      else
        logger.error "fetch HTTP - #{response.code} #{response.message}"
        nil
      end
    end

  end # class Page

end # module Factbook
