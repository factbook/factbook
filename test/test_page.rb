# encoding: utf-8


require 'helper'


class TestPage < MiniTest::Unit::TestCase

  def setup
    Dir.mkdir( 'tmp' )  unless Dir.exists?( 'tmp' )
  end

  def test_br
    page = Factbook::Page.new( 'br' )
    
    page.html = File.read( "#{Factbook.root}/test/data/countrytemplate_br.html" )

    ## print first 600 chars
    pp page.html[0..600]
    
    ## save for debuging
    
    puts "saving a copy to br.html for debugging"
    File.open( 'tmp/br.html', 'w') do |f|
      f.write( page.html )
    end

    doc   = page.doc
    sects = page.sects

    h = page.data
    pp h
    
    ### save to json
    puts "saving a copy to br.json for debugging"
    File.open( 'tmp/br.json', 'w') do |f|
      f.write( JSON.pretty_generate( h ) )
    end
  end


  def xxx_test_br
    page = Factbook::Page.new( 'br' )
    
    ## print first 600 chars
    pp page.html[0..600]
    
    ## save for debuging
    
    Dir.mkdir( 'tmp' )  unless Dir.exists?( 'tmp' )
    puts "saving a copy to br.html for debugging"
    File.open( 'tmp/br.html', 'w') do |f|
      f.write( page.html )
    end

    doc   = page.doc
    sects = page.sects

    rows      = doc.css( 'table tr' )
    field_ids = rows.css( '#field' )    ## check - use div#field.category -- possible?
    data_ids  = rows.css( '#data' )

    puts "rows.size:    #{rows.size}  (field_ids.size: #{field_ids.size} / data_ids.size: #{data_ids.size})"

    cats      = rows.css( '.category' )
    cats_div  = rows.css( 'div.category' )
    cats_span = rows.css( 'span.category' )
    cats_other_size = cats.size - cats_div.size - cats_span.size

    cats_data      = rows.css( '.category_data' )
    cats_div_data  = rows.css( 'div.category_data' )
    cats_span_data = rows.css( 'span.category_data' )
    cats_other_data_size = cats_data.size - cats_div_data.size - cats_span_data.size

    puts "cats.size:  #{cats.size} (cats_div.size #{cats_div.size} / cats_span.size #{cats_span.size} / cats_other.size #{cats_other_size})"
    puts "cats_data.size:  #{cats_data.size} (cats_div_data.size #{cats_div_data.size} / cats_span_data.size #{cats_span_data.size} / cats_other_data.size #{cats_other_data_size})"

    ## some check for structure
    if cats_other_size > 0
        puts " ****!!!! category other (not div/span) found - #{cats_other_size}"
    end
 
    if cats_other_data_size > 0
        puts " ****!!!! category_data other (not div/span) found - #{cats_other_data_size}"
    end

    ## stats( doc )

    sects.each_with_index do |sect,i|
      puts ''
      puts "############################"
      puts "#### stats sect #{i}:"
      pp page.sect_to_hash( sect )
    end
  end


  def stats( doc )
    rows  = doc.css( 'table tr' )
    cells = doc.css( 'table tr td' )
    field_ids = rows.css( '#field' )    ## check - use div#field.category -- possible?
    data_ids  = rows.css( '#data' )

    puts "rows.size:    #{rows.size}  (cells.size: #{cells.size} / field_ids.size: #{field_ids.size} / data_ids.size: #{data_ids.size})"

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
          text = cats.first.text.strip   # remove/strip leading and trailing spaces
          last_cat = text
          puts "  [#{i}] category: >>#{text}<<"
        else
          puts "**** !!!!!! warn/err - found element w/ field id  (no match for subsection!!! - check)"
          puts cell.to_s
        end

      elsif has_data_id

        cats      = cell.css( 'div.category' )   ## note: ignore all .category not using div (issue warn/err if found!!) etc.
        cats_data = cell.css( 'div.category_data,span.category_data' )  ## note: ignore a.category_data etc.
        cats_div_data  =  cell.css( 'div.category_data' )
        cats_span_data =  cell.css( 'span.category_data' )

        puts "    - [#{i}] data cell - cats: #{cats.size}, cats_data: #{cats_data.size} (cats_div_data: #{cats_div_data.size} / cats_span_data: #{cats_span_data.size})"

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
             puts "   **** !!! skipping non-div >#{child.name}<:"
             puts child.to_s
             next
           end

           ### check if .category or .category_data
           if child['class'] == 'category'
             
              ## collect text for category; exclude element w/ class.category_data
              text = ""
              child.children.each do |subchild|
                text << subchild.text.strip     unless subchild.element? && subchild['class'] == 'category_data'
              end
              
              value = child.css('span.category_data').text.strip

              puts "        -- category >>#{text}<<"

              ## start new pair
              last_pair = [ text, value ]
              last_pair_data_count = 0
              pairs << last_pair

           elsif child['class'] == 'category_data'
              puts "        -- category_data"

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
                last_pair[1] += "; #{text}"   ## append with separator 
              end
              last_pair_data_count += 1
              
           else
              puts "  **** !!! skipping div w/o category or category_data class:"
              puts child.to_s
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
        puts "#### !!!!  unknown cell type (no field or data id found):"
        puts cell.to_s
      end
    end # each cell
    
    pp hash
  end # method stats


end # class TestPage
