
module Factbook

class ItemBuilder       ## renameto ItemReader, ItemParser - why? why not??
  include LogUtils::Logging
  include NormalizeHelper    ##  e.g. normalize_category

def initialize( html, name )
  @html = html
  @name = name     # add category/field name e.g. Area, Location, etc.
end



##
## <div class="category_data subfield text">
## Portuguese  (official and most widely spoken language)
##
## </div>
## <div class="category_data note">
## <p><strong>note:</strong> less common languages include Spanish (border areas and schools), German, Italian, Japanese, English, and a large number of minor Amerindian languages</p>
## </div>


def read
  ## return hash from html snippet
  doc = Nokogiri::HTML.fragment( @html )

  data = {}

  ## note:
  ##   skip whitespace text nodes (e.g. \n\n etc); just use divs
  doc_children = doc.children.filter('div')

  puts "  parsing >#{@name}< - #{doc_children.size} category_data divs(s):"

  ## hanlde special case for
  ##  multiple 'grouped_subfield' first
  ##  e.g. used in
  ##   - Drinking water source:
  ##   - Sanitation facility access:

  grouped_children = []
  other_children   = []

  doc_children.each do |div|
     if div['class'] && div['class'].index( 'grouped_subfield' )
        grouped_children << div
     else
        other_children << div
     end
  end


  ## note: only use special rule if more than one div marked grouped_
  if grouped_children.size > 1
    ## continue processing the rest as usual
    doc_children =  other_children

    key = nil
    grouped_children.each do |div|
       if !div.css( 'span.subfield-group').empty?
         # start a new group
         span_group = div.at( 'span.subfield-group')
         key  = normalize_category( span_group.text.strip )
         span_group.replace( '' )

         text = squish( div.text.strip )
         puts "new group - category_data key >#{key}<: >#{text}<"
         data[ key ] = { 'text' => text }
       else
         ## append to (last) group
         text = squish( div.text.strip )
         puts "add group - category_data key >#{key}<: >#{text}<"
         data[ key ]['text'] += " / #{text}"
       end
    end
  end


doc_children.each_with_index do |div,i|
  if div['class'] && div['class'].index( 'category_data' )
    if div['class'].index( 'note' )
      text = squish( div.text.strip )
      puts "category_data: >#{text}<"

      ## note: for now only allow one note per subsection/field data block
      if data['note']
        puts "!! ERROR: note already taken:"
        puts data['note']
        puts  div.to_html
        exit 1
      end

      ## note: add note directly (that is, W/O extra hash and text node/key)
      data['note'] = text
    elsif div['class'].index( 'historic' )
      ## add all historic together into one for now
        text = squish( div.text.strip )
        puts "category_data: >#{text}<"

        if data['text']
          ## append with / for now
          data['text'] += " / #{text}"
        else
          data['text'] = text
          ## check if history is first node
          if i != 0
            puts "!! ERROR: expected first historic node to be first node but it is #{i+1}:"
            puts div.to_html
            exit 1
          end
        end
      elsif div.css( 'span.subfield-name').empty?
        ## assume "implied text field"
        ## check for index == 1 / child count == 1 - why? why not
        text = squish( div.text.strip )    ## fix/todo: use strip
        puts "category_data: >#{text}<"

        data['text'] = text

        ## must be always first node for now
        if i != 0
          puts "!! ERROR - 'implied' category W/O name NOT first div / node:"
          puts div.to_html
          exit 1
        end
    elsif div['class'].index( 'grouped_subfield' )
## split grouped subfield!!
##   <span class="subfield-name">arable land:</span>
## <span class="subfield-number">8.6%</span>
## <span class="subfield-date">(2011 est.)</span>
##  /
## <span class="subfield-name">permanent crops:</span>
## <span class="subfield-number">0.8%</span>
## <span class="subfield-date">(2011 est.)</span>
##   /
## <span class="subfield-name">permanent pasture:</span>
## <span class="subfield-number">23.5%</span>
## <span class="subfield-date">(2011 est.)</span>

## join names for now - why? why not?
##  e.g. becomes:
##   arable land / permanent crops / permanent pasture: for key ??
     span_names = div.css( 'span.subfield-name')
     keys = []
     span_names.each do |span|
       keys << normalize_category( span.text.strip )
       span.replace( '' )
     end
     key = keys.join( ' / ')
     text = squish( div.text.strip )
     puts "category_data key >#{key}<: >#{text}<"
     data[ key ] = { 'text' => text }
    else
      ## get subfield name
      span_names = div.css( 'span.subfield-name')
      if span_names.size > 1
        puts "!! ERROR - found more than one subfield-name:"
        puts div.to_html
        exit 1
      end
      key = normalize_category( span_names[0].text.strip )
      span_names[0].replace( '' )

      text = squish( div.text.strip )
      puts "category_data key >#{key}<: >#{text}<"
      data[ key ] = { 'text' => text }
    end
  else
      text = squish( div.text.strip )
      if text =~ /country\s+
                  comparison\s+
                  to\s+
                  the\s+
                  world:\s+
                  ([0-9]+)/xim
        data[ 'country comparison to the world' ] = $1.to_i
      else
        puts "!! ERROR: div (W/O category_data class):"
        puts div.to_html
        exit 1
      end
  end
end


  pp data
  data
end




def squish( str )
  str.gsub( /[ \t\n\r]{2,}/, ' ')  ## replace multi-spaces (incl. newlines with once space)
end

end # class ItemBuilder

end # module Factbook
