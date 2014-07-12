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

    def data
      if @data.nil?
        titles = [
         'intro',
         'geo',
         'people',
         'govt',
         'econ',
         'energy',
         'comm',
         'trans',
         'military',
         'issues' ]

        @data = {}

        sects.each_with_index do |sect,i|
          logger.debug "############################"
          logger.debug "###  stats sect #{i}:"

          @data[ titles[i] ] = sect_to_hash( sect )
        end
      end
      @data
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


  def cleanup_key( key )
    ## to lower case
    key = key.downcase
    ## seaport(s)  => seaports
    key = key.gsub( '(s)', 's' )
    key = key.gsub( ':', '' )    # trailing :
    ## remove special chars ()-/,'
    key = key.gsub( /[()\-\/,]'/, ' ')
    key = key.strip
    key = key.gsub( /[ ]+/, '_' )
    key
  end


  def sect_to_hash( sect )

    rows  = sect.css( 'table tr' )
    cells = sect.css( 'table tr td' )
    field_ids = rows.css( '#field' )    ## check - use div#field.category -- possible?
    data_ids  = rows.css( '#data' )

    logger.debug "rows.size:    #{rows.size}  (cells.size: #{cells.size} / field_ids.size: #{field_ids.size} / data_ids.size: #{data_ids.size})"

    hash = {}
    last_cat = nil

    cells.each_with_index do |cell,i|
      ## next if i > 14   ## skip after xx for debugging for now

      # check if field or data id
      # check for (nested) div#field in td
      has_field_id  =  cell.css( '#field' ).size == 1 ? true : false

      # check for td#data
      has_data_id =  cell['id'] == 'data' ? true : false

      if has_field_id

        cats  = cell.css( 'div.category' )   ## note: ignore all .category not using div (issue warn/err if found!!) etc.
        if cats.size == 1
          text = cleanup_key( cats.first.text.strip )   # remove/strip leading and trailing spaces
          last_cat = text
          logger.debug "  [#{i}] category: >>#{text}<<"
        else
          logger.warn "**** !!!!!! warn/err - found element w/ field id  (no match for subsection!!! - check)"
          logger.warn cell.to_s
        end

      elsif has_data_id

        cats      = cell.css( 'div.category' )   ## note: ignore all .category not using div (issue warn/err if found!!) etc.
        cats_data = cell.css( 'div.category_data,span.category_data' )  ## note: ignore a.category_data etc.
        cats_div_data  =  cell.css( 'div.category_data' )
        cats_span_data =  cell.css( 'span.category_data' )

        logger.debug "    - [#{i}] data cell - cats: #{cats.size}, cats_data: #{cats_data.size} (cats_div_data: #{cats_div_data.size} / cats_span_data: #{cats_span_data.size})"

        pairs = []
        last_pair = nil
        last_pair_data_count = 0

        ## loop over div blocks (might be .category or .category_data)
        cell.children.each_with_index do |child,j|
           unless child.element?
             ## puts "   **** !!!! skipping non-element type >#{child.type}<:"
             ## puts child.to_s
             next
           end
           unless child.name == 'div'
             logger.warn "   **** !!! skipping non-div >#{child.name}<:"
             logger.warn child.to_s
             next
           end

           ### check if .category or .category_data
           if child['class'] == 'category'
             
              ## collect text for category; exclude element w/ class.category_data
              text = ""
              child.children.each do |subchild|
                text << subchild.text.strip     unless subchild.element? && subchild['class'] == 'category_data'
              end
              text = cleanup_key( text )

              value = child.css('span.category_data').text.strip

              logger.debug "        -- category >>#{text}<<"

              ## start new pair
              last_pair = [ text, value ]
              last_pair_data_count = 0
              pairs << last_pair

           elsif child['class'] == 'category_data'
              logger.debug "        -- category_data"

              text = child.text.strip

              if last_pair.nil?
                ## assume its the very first entry; use implied/auto-created category
                last_pair = [ 'text', '' ]
                last_pair_data_count = 0
                pairs << last_pair
              end

              ### first category_data element?
              if last_pair_data_count == 0
                if last_pair[1] == ''
                  last_pair[1] = text
                else
                  last_pair[1] += " #{text}"    ## append w/o separator
                end
              else
                if last_cat == 'demographic_profile'  ## special case (use space a sep)
                  last_pair[1] += " #{text}"   ## append with separator
                else
                  last_pair[1] += "; #{text}"   ## append with separator
                end
              end
              last_pair_data_count += 1
              
           else
              logger.warn "  **** !!! skipping div w/o category or category_data class:"
              logger.warn child.to_s
           end
        end

        ## pp pairs
        
        ## pairs to hash
        pairs_hash = {}
        pairs.each do |pair|
          pairs_hash[ pair[0] ] = pair[1]
        end

        hash[ last_cat ] = pairs_hash

      else
        logger.warn "#### !!!!  unknown cell type (no field or data id found):"
        logger.warn cell.to_s
      end
    end # each cell
    
    hash  # return hash

  end # method sect_to_hash

  end # class Page

end # module Factbook
