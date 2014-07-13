# encoding: utf-8

module Factbook

  class Sect   # section (e.g. Introduction/Geography/People/Economy/Energy/Transport/etc.)
    include LogUtils::Logging

    attr_reader :title, :html

    def initialize( title, html )
      ## todo: passing a ref to the parent page - why? why not??
      @title = title
      @html  = html
      
      @doc   = nil
      @data  = nil
    end

    def doc
      ### check: use nokogiri html fragment? why? why not??
      @doc ||= Nokogiri::HTML( @html )
    end

    def data
      @data ||= sect_to_hash( doc )
    end

private

  def cleanup_key( key )
    ## to lower case
    key = key.downcase
    ## seaport(s)  => seaports
    key = key.gsub( '(s)', 's' )
    key = key.gsub( ':', '' )    # trailing :
    ## remove special chars ()-/,'
    key = key.gsub( /['()\-\/,]/, ' ' )
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

  end  # class Sect

end # module Factbook
