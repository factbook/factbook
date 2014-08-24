# encoding: utf-8

module Factbook


  class Page
    include LogUtils::Logging
 
    ## standard version
    ## SITE_BASE = 'https://www.cia.gov/library/publications/the-world-factbook/geos/{code}.html'
    
    ## -- use text (low-bandwidth) version
    ## e.g. www.cia.gov/library/publications/the-world-factbook/geos/countrytemplate_br.html
    SITE_BASE = 'https://www.cia.gov/library/publications/the-world-factbook/geos/countrytemplate_{code}.html'
                 
    def initialize( code, opts={} )
      ## note: requires factbook country code
      #   e.g. austria is au
      #        germany is gm  and so on
      @code  = code
      
      ### rename fields to format option?? why? why not? e.g. :format => 'long' ??
      @opts  = opts   # fields:  full|long|keep|std|??  -- find a good name for the option keeping field names as is

      @html  = nil
      @doc   = nil
      @sects = nil
      @data  = nil
    end

    def doc
      @doc ||= Nokogiri::HTML( html )
    end

    def to_json( opts={} )
      ## convenience helper for data.to_json
      if opts[:pretty] || opts[:pp]
        JSON.pretty_generate( data )
      else
        data.to_json
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


    def data
      if @data.nil?
        @data = {}

        if @opts[:header]   ## include (leading) header section ??
          
          header_key =     @opts[:fields] ? 'Header' : 'header'
          last_built_key = @opts[:fields] ? 'last built' : 'last_built'

          @data[header_key] = {
            'code' => @code,
            'generator' => "factbook/#{VERSION}",
            last_built_key => "#{Time.now}",
          }
        end

        sects.each_with_index do |sect,i|
          logger.debug "############################"
          logger.debug "###  [#{i}] stats sect >#{sect.title}<: "

          @data[ sect.title ] = sect.data
        end
      end
      @data
    end


    def sects
      if @sects.nil?
        ## split html into sections
        ##   lets us avoids errors w/ (wrongly) nested tags

        ## check opts for using long or short category/field names
        divs = [
          [ @opts[:fields] ? 'Introduction'        : 'intro',    '<div id="CollapsiblePanel1_Intro"'   ],
          [ @opts[:fields] ? 'Geography'           : 'geo',      '<div id="CollapsiblePanel1_Geo"'     ],
          [ @opts[:fields] ? 'People and Society'  : 'people',   '<div id="CollapsiblePanel1_People"'  ],
          [ @opts[:fields] ? 'Government'          : 'govt',     '<div id="CollapsiblePanel1_Govt"'    ],
          [ @opts[:fields] ? 'Economy'             : 'econ',     '<div id="CollapsiblePanel1_Econ"'    ],
          [ @opts[:fields] ? 'Energy'              : 'energy',   '<div id="CollapsiblePanel1_Energy"'  ],
          [ @opts[:fields] ? 'Communications'      : 'comm',     '<div id="CollapsiblePanel1_Comm"'    ],
          [ @opts[:fields] ? 'Transportation'      : 'trans',    '<div id="CollapsiblePanel1_Trans"'   ],
          [ @opts[:fields] ? 'Military'            : 'military', '<div id="CollapsiblePanel1_Military"'],
          [ @opts[:fields] ? 'Transnational Issues': 'issues',   '<div id="CollapsiblePanel1_Issues"'  ]
        ]

        indexes = []

        ## note:
        ##   skip missing sections (w/ warning)
        ##   e.g. Vatican (Holy See), Liechtenstein etc. have no Energy section, for example

        divs.each_with_index do |rec,i|
          title = rec[0]
          div   = rec[1]
          p = html.index( div )
          if p.nil?
            ## issue warning: if not found
            logger.warn "***!!! section not found -- #{div} --; skipping"
          else
            logger.debug "  found section #{i} @ #{p}"
            indexes <<  [title,p]
          end
        end

        @sects = []

        indexes.each_with_index do |rec,i|
          title = rec[0]
          from  = rec[1]

          # is last entry? if yes use -1 otherewise pos
          #   note: subtract one (-1) from pos unless end-of-string (-1)
          to    = indexes[i+1].nil? ? -1 : indexes[i+1][1]-1

          ## todo: check that from is smaller than to
          logger.debug "   cut section #{i} [#{from}..#{to}]"
          @sects << Sect.new( title, html[ from..to ], @opts )

          ##if i==0 || i==1
            ## puts "debug sect #{i}:"
            ## puts ">>>|||#{html[ from..to ]}|||<<<"
          ##end
        end
      end

      @sects
    end

    def html=(html)
      ## for debugging n testing
      ## lets you set html (no need to fetch via net)
      @html = html
    end

    def html
      if @html.nil?
        @html = fetch()

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
