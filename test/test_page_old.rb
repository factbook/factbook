# encoding: utf-8


require 'helper'


class TestPageOld < MiniTest::Test


  def xxx_test_br
    Dir.mkdir( 'tmp' )  unless Dir.exists?( 'tmp' )

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


  def xxx_stats( doc )
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


  def yyy_test_mx
    page = Factbook::Page.new( 'mx' )
    
    ## print first 600 chars
    pp page.html[0..600]
    
    doc = page.doc

    panels    = doc.css( '.CollapsiblePanel' )
    questions = doc.css( '.question' )
    answers   = doc.css( '.answer' )

    puts "panels.size:    #{panels.size}"
    puts "questions.size: #{questions.size}"
    puts "answers.size:   #{answers.size}"

    cats0      = panels[0].css( '.category' )
    cats0_data = panels[0].css( '.category_data' )

    puts "cats0.size:       #{cats0.size}"
    puts "cats0_data.size:  #{cats0_data.size}"

    cats1      = panels[1].css( '.category' )
    cats1_data = panels[1].css( '.category_data' )

    puts "cats1.size:       #{cats1.size}"
    puts "cats1_data.size:  #{cats1_data.size}"


    ## fix: use cats -- add s
    cat = doc.css( '#CollapsiblePanel1_Geo div.category' )
    puts "cat.size: #{cat.size}"

    catcheck = doc.css( '#CollapsiblePanel1_Geo .category' )
    puts "catcheck.size: #{catcheck.size}"

    catcheck2 = doc.css( '.category' )
    puts "catcheck2.size: #{catcheck2.size}"


    catdata = doc.css( '#CollapsiblePanel1_Geo .category_data' )
    puts "catdata.size: #{catdata.size}"

    catdatacheck2 = doc.css( '.category_data' )
    puts "catdatacheck2.size: #{catdatacheck2.size}"

    puts "catdata[0]:"
    pp catdata[0]

    puts "catdata[1]:"
    pp catdata[1]

#    puts "catdata[2]:"
#    pp catdata[2]

#    puts "catdata[0].text():"
#    pp catdata[0].text()

#    puts "cat[0].text():"
#    pp cat[0].text()

#    cat.each_with_index do |c,i|
#      puts "[#{i+1}]: ========================="
#      puts ">>#{c.text()}<<"
#    end

  end

  def yyy_test_mx
    page = Factbook::Page.new( 'mx' )
    
    ## print first 600 chars
    pp page.html[0..600]
    
    ## save for debuging
    
    Dir.mkdir( 'tmp' )  unless Dir.exists?( 'tmp' )
    puts "saving a copy to mx.html for debugging"
    File.open( 'tmp/mx.html', 'w') do |f|
      f.write( page.html )
    end

    doc   = page.doc
    sects = page.sects

    panels    = doc.css( '.CollapsiblePanel' )
    questions = doc.css( '.question' )
    answers   = doc.css( '.answer' )

    puts "panels.size:    #{panels.size}"
    puts "questions.size: #{questions.size}"
    puts "answers.size:   #{answers.size}"

    rows_total = 0
    panels.each_with_index do |panel,i|
      rows = panel.css( 'table tr' )
      puts "  [#{i}] rows.size:  #{rows.size}"
      rows_total += rows.size
    end

    puts "rows_total: #{rows_total}"

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
      stats( sect )
    end
  end


  def yyy_stats( doc )
    rows  = doc.css( 'table tr' )
    cells = doc.css( 'table tr td' )
    field_ids = rows.css( '#field' )    ## check - use div#field.category -- possible?
    data_ids  = rows.css( '#data' )

    puts "rows.size:    #{rows.size}  (cells.size: #{cells.size} / field_ids.size: #{field_ids.size} / data_ids.size: #{data_ids.size})"


    ## check rows
    ## todo/fix:
    ##  loop over td's !!!
  
    cells.each_with_index do |cell,i|
      ## next if i > 14   ## skip after xx for debugging for now

      cats      = cell.css( 'div.category' )   ## note: ignore all .category not using div (issue warn/err if found!!) etc.
      cats_data = cell.css( 'div.category_data,span.category_data' )  ## note: ignore a.category_data etc.
      cats_div_data  =  cell.css( 'div.category_data' )
      cats_span_data =  cell.css( 'span.category_data' )

      field_ids = cell.css( '#field' )    ##  td div.field  check - use div#field.category -- possible?
      
      ### fix: split into #field and #data
      ##   field has no category-data no sub/multiple categories etc.
      
      ## td#data
      # quick hack: use parent() - fix!! check id for element if present and is data how?? e.g. cell['id'] == 'data' ???
      data_ids  = cell.parent.css( '#data' )  ## will include self? e.g. td id='data' ???
      
      ids_size = field_ids.size + data_ids.size

      if ids_size == 0
         puts " ****!!!! no ids (field/data) found"
      end
      
      if ids_size > 1
         puts "  ***!!! more than one id (field/data) found - #{ids_size}"
      end
      

      ## check for subcategory
      ##   must be div w/ id field and class category

      if field_ids.size == 1    ## assume category

        if cats.size == 1 && cats_data.size == 0 && cats.first.name == 'div'
          text = cats.first.text.strip   # remove/strip leading and trailing spaces
          puts "  [#{i}] category: >>#{text}<<"
        else
          puts "**** !!!!!! warn/err - found element w/ field id  (no match for subsection!!! - check)"
        end

      elsif data_ids.size == 1

        if cats.size == 0
          if cats_data.size == 1    ## check for cats_data.first.name == 'div' too ???
            text = cats_data.first.text.strip   # remove/strip leading and trailing spaces
            puts "       - [#{i}] data: >>#{text}<<"          
          elsif cats_data.size > 1  ## check for cats_data.first.name == 'div' too ???
            ary = []
            cats_data.each do |cat_data|
              ary << cat_data.text.strip
            end
            text = ary.join( '; ' )
            puts "       - [#{i}] data#{cats_data.size}: >>#{text}<<"
          else
            # should not happen
            puts "*** !!!! warn/err - skip empty data cell (no cats/no cats_data)"
          end
        elsif cats.size > 0
          puts "     [#{i}] cats: #{cats.size}, cats_data: #{cats_data.size} (cats_div_data: #{cats_div_data.size}/ cats_span_data: #{cats_span_data.size})"
        
        
          ## check for "free standing" data blocks (not assigned to category/key)
          if cats_div_data.size > 1
            if cats_div_data.size == 1    #
              # check if first or last entry (if first entry use key *text*; otherwise use key *notes*)
            else   ## multiple (more than one) data divs
              if cats.size == 1  
                # always assume text for now (not *notes*)
              else
                # multiple cats and multiple data divs (e.g. drinking water source:)
                #   to be done - for now use one all-in-one text blob
              end
            end
          end
        
          cats.each_with_index do |cat,j|  # note: use index - j (for inner loop)
            ## get text from direct child / children
            ##  do NOT included text from  nested span - how? possible?
            ## text = cat.css( ':not( .category_data )' ).text.strip  ## will it include text node(s)??
            ## text = cat.text.strip  ## will it include text node(s)??
            ## text =  cat.css( '*:not(.category_data)' ).text.strip
            # Find the content of all child text nodes and join them together
            
            ## collect text for category; exclude element w/ class.category_data
            text = ""
            cat.children.each do |child|
              text << child.text.strip     unless child.element? && child['class'] == 'category_data'
            end
            
            ## text = cat.xpath('text()').text.strip
            
            n  = cat.css( '.category_data' )
            ## or use
            ## text = cat.children.first.text ??
            puts "     -- [#{j}] subcategory: >>#{text}<<  cats_data: #{n.size}"
            ## pp cat.css( '*:not(.category_data)' )
            ## pp cat.css( "*:not(*[@class='category_data'])" )   # *[@class='someclass']
            ## pp cat
            ## check if is div - if not issue warn
            if cat.name == 'div'
              ## check if includes one or more category_data nodes
              if n.size == 0
                puts "         ****** !!! no category_data inside"
              end
              if n.size > 1
                puts "         ****** !!! multiple category_data's inside - #{n.size}"
              end
            else
              puts "         ****** !!!! no div - is >>#{cat.name}<<"
            end
          end
        else
          puts "**** !!!!!! warn/err - found element w/ data id (no cats, no cats-data) [#{i}] cats:   #{cats.size},  cats_data: #{cats_data.size}, data_ids: #{data_ids.size}"
        end
      else
        puts "**** !!!!!!! [#{i}] cats:   #{cats.size}, cats_data: #{cats_data.size}, field_ids: #{field_ids.size}, data_ids: #{data_ids.size}"
      end


      if cats.size > 1
        ## puts cell.to_s
      end
   end # each cell

  end


end # class TestPageOld
