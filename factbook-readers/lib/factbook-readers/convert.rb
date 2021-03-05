

def convert_cia( cia )
 ## convert from "raw" on-the-wire cia format to
 ##   "standard" compact "classic" format

  data = {}

  cia['categories'].each do |cia_cat|
     cat = data[ cia_cat['title'] ] = {}
     cia_cat['fields'].each do |cia_field|
       field = cat[ cia_field['name'] ] = {}
       if cia_field['subfields']
         cia_field['subfields'].each do |cia_subfield|
           subfield = field[ cia_subfield['name'] ] = {}
           subfield[ 'text' ] = cia_subfield['content']
         end

         puts "== #{cia_cat['title']} / #{cia_field['name']} - skipping field content (w/ subfields):"
         puts "   >#{cia_field['content']}<"
         puts "   ?? same as:"
         cia_field['subfields'].each do |cia_subfield|
           puts "   #{cia_subfield['name']}: >#{cia_subfield['content']}<"
         end

       else
         field[ 'text' ] = cia_field['content']
       end

       if cia_field[ 'field_note' ]
         field[ 'note' ] = cia_field[ 'field_note' ]
       end
     end
  end

  data
end
