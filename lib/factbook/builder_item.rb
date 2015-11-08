# encoding: utf-8

module Factbook

class ItemBuilder       ## renameto ItemReader, ItemParser - why? why not??
  include LogUtils::Logging
  include NormalizeHelper    ##  e.g. normalize_category
  
def initialize( html, name )
  @html = html
  @name = name     # add category/field name e.g. Area, Location, etc.
end
  
def read
  ## return hash from html snippet
  doc = Nokogiri::HTML.fragment( @html )

  data = {}
  last_node = nil     ## track last hash (always use text key)
  last_node_data_count = 0

  ## note:
  ##   skip whitespace text nodes (e.g. \n\n etc); just use divs
  doc.children.filter('div').each_with_index do |child,i|

    if child['class'] == 'category_data'
       text = child.text    ## fix/todo: use strip
       puts "category_data: >#{text}<"
       
       if last_node.nil?
          ## assume its the very first entry; use implied/auto-created category
          data['text'] = ''
          last_node = data     
          last_node_data_count = 0
       end

       ### first category_data element?
      if last_node_data_count == 0
         if last_node['text'] == ''
            last_node['text'] = text
         else   ### possible ??? if data_count is zero - not should not include any data
            ## todo: issue warning here - why? why not??
            last_node['text'] += " #{text}"    ## append w/o separator
         end
      else
        if @name == 'Demographic profile'  ## special case (use space a sep)
            last_node['text'] += " #{text}"   ## append without (w/o) separator
        else
            last_node['text'] += " ++ #{text}"   ## append with ++ separator
        end
      end
      last_node_data_count += 1

    elsif child['class'].nil?    ## div without any class e.g. <div>..</div>
                                 ##   assume category and category_data pair w/ spans
      spans = child.children.filter('span')
      if spans.size > 2
        puts "*** warn: expected two (or one) spans; got #{spans.inspect}"
      end
      
      ## pp spans
      
      span_key   = spans[0]  ## assume 1st entry is span.category
      span_value = spans[1]  ## assume 2nd entry is span.category_data
      
      key   = normalize_category( span_key.text )

      ## note: allow optional category_data for now
      value = span_value ? span_value.text : nil
      
      puts "key: >#{key}<, value: >#{value}< : #{value.class.name}"

      ## start new pair
      last_node = data[key] = { 'text' => value }
      last_node_data_count =  value ? 1 : 0    ## note: set to 1 if value present
    else
      puts "*** warn: item builder -- unknow css class in #{child.inspect}"
    end
    
    ## pp child
    ## css = child['class']
    ## puts "[#{i}] #{child.name}  class='>#{css}< : #{css.class.name}' >#{child.text}<"
  end
  
  pp data
  data
end

  
end # class ItemBuilder

end # module Factbook
