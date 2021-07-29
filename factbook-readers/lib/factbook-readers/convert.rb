

module CiaOnline    ## todo/check: rename? find a better module name - why? why not?
  extend self   ## note: (automagically) make all methods class-level
                ##            e.g. lets you call CiaOnline.convert etc.


def convert( cia, sanitize: true )
 ## convert from "raw" on-the-wire cia format to
 ##   "standard" compact "classic" format

  data = {}

  cia['categories'].each do |cia_cat|
     cat = data[ cia_cat['title'] ] = {}
     cia_cat['fields'].each do |cia_field|
       field = cat[ cia_field['name'] ] = {}

       ## case 1 - field has subfields? yes, use content of subfields as text
       ##  - drop redundant (?) field content - assume same as aggregate of all subfield content
       if cia_field['subfields']
         cia_field['subfields'].each do |cia_subfield|
           subfield = field[ cia_subfield['name'] ] = {}
           text = cia_subfield['content']
           text = sanitize( text )  if sanitize
           subfield[ 'text' ] = text
         end

         # puts "== #{cia_cat['title']} / #{cia_field['name']} - skipping field content (w/ subfields):"
         # puts "   >#{cia_field['content']}<"
         # puts "   ?? same as:"
         # cia_field['subfields'].each do |cia_subfield|
         #  puts "   #{cia_subfield['name']}: >#{cia_subfield['content']}<"
         # end

         ## todo/check/fix:  check if subfield_note exits?

       ## case 2 - no subfields - use field content as text
       else
         text = cia_field['content']
         text = sanitize( text )  if sanitize
         field[ 'text' ] = text
       end

       ## bonus - check for field note
       if cia_field[ 'field_note' ]
         text = cia_field[ 'field_note' ]
         text = sanitize( text )  if sanitize
         field[ 'note' ] = text
       end
     end
  end

  data
end  # method convert


HTML_OPEN_TAG_RE = %r{<[^>]+?>     # note: use non-greedy (minimal/first) match e.g. +?
                     }x

def sanitize( text )
   ## rough check if html tags present
  if text =~ HTML_OPEN_TAG_RE
    doc = Nokogiri::HTML::fragment( text )

    ## step 1) unwrap all span & div tags
    ##              plus  sup tags  e.g. 12<sup>th</sup> etc.
    ##  (note: requires recursive depht-first tree navigation on inplace replace!)
    unwrap_recurse( doc, tags: ['span', 'div', 'sup'] )

    ## step 2) unlink, that is, replace all links <a></a> with text only
    unlink( doc )

    text = doc.to_html
  end
  text
end


#####
# sanitize (html with nokogire) helpers
def unwrap_recurse( node, tags: )   ## default to unwrap ['span'] tag only for now
  # note: depth first so we don't accidentally modify a collection while
  # we're iterating through it
  node.elements.each do |child|
    unwrap_recurse( child, tags: tags )
  end

  # replace this element's children with it's grandchildren
  # assuming it meets all the criteria
  node.replace( node.inner_html )   if tags.include?( node.name )   ## check: always downcase needed - why? why not?
end

def unlink( node )   ## replace links (<a> tags) with text only
  node.css('a').each do |el|
    el.replace( el.inner_html )
  end
end

end  # module CiaOnline





########
#  global convenience helpers

def convert_cia( data, sanitize: true )
  CiaOnline.convert( data, sanitize: sanitize )
end

