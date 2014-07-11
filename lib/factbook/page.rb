# encoding: utf-8

module Factbook

  class Page

    include LogUtils::Logging
 
    ## standard version
    ## SITE_BASE = 'https://www.cia.gov/library/publications/the-world-factbook/geos/{code}.html'
    
    ## -- use text (low-bandwidth) version
    ## e.g. www.cia.gov/library/publications/the-world-factbook/geos/countrytemplate_br.html
    SITE_BASE = 'https://www.cia.gov/library/publications/the-world-factbook/geos/countrytemplate_{code}.html'
                 
    def initialize( code )
      @code = code
    end

    def doc
      @doc ||= Nokogiri::HTML( html )
    end


    def sects
      ## split html into sections
      ##   to avoid errors w/ nested tags
      
      divs = [
        '<div id="CollapsiblePanel1_Intro"',
        '<div id="CollapsiblePanel1_Geo"',
        '<div id="CollapsiblePanel1_People"',
        '<div id="CollapsiblePanel1_Govt"',
        '<div id="CollapsiblePanel1_Econ"',
        '<div id="CollapsiblePanel1_Energy"',
        '<div id="CollapsiblePanel1_Comm"',
        '<div id="CollapsiblePanel1_Trans"',
        '<div id="CollapsiblePanel1_Military"',
        '<div id="CollapsiblePanel1_Issues"' ]
      
      if @sects.nil?
        @sects = []

        @pos = []
        divs.each_with_index do |div,i|
          p = html.index( div )
          if p.nil?
            ## issue error: if not found
            puts "*** error: section not found -- #{div}"
          else
            puts "  found section #{i} @ #{p}"
          end
          
          @pos <<  p
        end
        @pos << -1   ## note: last entry add -1 for until the end of document
        
        divs.each_with_index do |div,i|
          from = @pos[i] 
          to   = @pos[i+1]
          to -= 1  unless to == -1 ## note: sub one (-1) unless end-of-string (-1)

          ## todo: check that from is smaller than to
          puts "   cut section #{i} [#{from}..#{to}]"
          @sects << Nokogiri::HTML( html[ from..to ] )
          
          if i==0 || i==1
            # puts "debug sect #{i}:"
            # puts ">>>|||#{html[ from..to ]}|||<<<"
          end
        end
      end

      @sects
    end


    def html
      if @html.nil?
        ## @html = fetch()
        @html = File.read( "#{Factbook.root}/countrytemplate_br.html" )

      ### remove everything up to 
      ##   <div id="countryInfo" style="display: none;">
      ## remove everything starting w/ footer
      ## remove head !!!
      ## in body remove header n footer

        ## remove inline script
        @html = @html.gsub( /<script[^>]*>.*?<\/script>/m ) do |m|
          puts "remove script:"
          puts "#{m}"
          ''
        end

        ## remove inline style
        @html = @html.gsub( /<style[^>]*>.*?<\/style>/m ) do |m|
          puts "remove style:"
          puts "#{m}"
          ''
        end

        ## remove link
        link_regex = /<link[^>]+>/
        @html = @html.gsub( link_regex ) do |m|
          puts "remove link:"
          puts "#{m}"
          ''
        end

        div_country_info_regex = /<div id="countryInfo"\s*>/
        ## remove everything before <div id="countryInfo" >
        pos = @html.index( div_country_info_regex )
        if pos  # not nil, false
          @html = @html[pos..-1]
        end

        ## remove country comparison
        ## e.g.  <span class="category" >country comparison to the world:</span>
        ##       <span class="category_data">
        ##  <a href="../rankorder/2147rank.html?countryname=Brazil&countrycode=br&regionCode=soa&rank=5#br" onMouseDown=""  title="Country comparison to the world" alt="Country comparison to the world">
        ##    5
        ##  </a>
        ##  </span>
        
        ##
        ##
        ## <span class="category" style="padding-left:7px;">country comparison to the world:</span> <span class="category_data">
        ##  <a href="../rankorder/2147rank.html?countryname=Brazil&countrycode=br&regionCode=soa&rank=5#br" onMouseDown=""  title="Country comparison to the world" alt="Country comparison to the world"> 5 </a> </span>
        ##

        country_comparison_regex = /
         <span \s class="category"[^>]*>
           country \s comparison \s to \s the \s world:
         <\/span>
          \s*
         <span \s class="category_data"[^>]*>
          \s*
            <a \s [^>]+>
             .+?
            <\/a>
          \s*
         <\/span>
        /xm

        @html = @html.gsub( country_comparison_regex ) do |m|
          puts "remove country comparison:"
          puts "#{m}"
          ''
        end
        
        style_attr_regex = /\s*style="[^"]+"/
        @html = @html.gsub( style_attr_regex ) do |m|
          puts "remove style attr:"
          puts "#{m}"
          ''
        end
        
        ## <tr height="22">
        ##   <td class="category_data"></td>
        ##   </tr>
        tr_empty_regex = /
           <tr[^>]*>
             \s*
              <td[^>]*> \s* <\/td>
             \s*
           <\/tr>
        /xm
        @html = @html.gsub( tr_empty_regex ) do |m|
          puts "remove tr emtpy:"
          puts "#{m}"
          ''
        end

        ##  remove world leader website promo
        ##  <span class="category">(For more information visit the
        ##     <a href="/library/publications/world-leaders-1/index.html" target="_blank">World Leaders website</a>&nbsp;
        ##       <img src="../graphics/soa_newwindow.gif" alt="Opens in New Window" title="Opens in New Window" border="0"/>)
        ##  </span>
        world_leaders_website_regex = /
         <span \s class="category"[^>]*>
           \(
           For \s more \s information \s
            .+?       ## non-greedy (smallest possible match
           \)
         <\/span>
        /xm
        @html = @html.gsub( world_leaders_website_regex ) do |m|
          puts "remove world leader website promo:"
          puts "#{m}"
          ''
        end

      end
      @html
    end

  private
    def fetch
      uri_string = SITE_BASE.gsub( '{code}', @code )

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
