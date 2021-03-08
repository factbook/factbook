#####################################
#  use to run:
#   ruby pages/fields.rb


require_relative 'helper'


counter = {}

##  see github.com/factbook/factbook.json   (use git clone)
json_dir = '../../factbook/cache.factbook.json'


Factbook.codes.each do |code|
  path = "#{json_dir}/#{code.region_slug}/#{code.code}.json"
  text = File.open( path, 'r:utf-8') {|f|f.read }
  data = JSON.parse( text )

  data['categories'].each do |category|
      title = category['title']
      h1 = counter[ title ] ||= { count: 0, codes: [], fields: {} }
      h1[ :count ] += 1

      ## delete codes if larger (treshhold) than x (e.g. 9)
      h1.delete( :codes )    if h1[ :count ] > 9

      h1[ :codes ] << code.code   if h1[ :codes ]   ## note: might got deleted if passed treshhold (e.g. 9 entries)

      category['fields'].each do |field|
         fields = h1[ :fields ]

         name        = field['name']
         field_id    = field['field_id']
         comparative = field['comparative']

         h2 = fields[ name ] ||= { count: 0, codes: [] }

         h2[ :count ] += 1

         ## delete codes if larger (treshhold) than x (e.g. 9)
         h2.delete( :codes )    if h2[ :count ] > 9

         h2[ :codes ] << code.code   if h2[ :codes ]   ## note: might got deleted if passed treshhold (e.g. 9 entries)

         if h2[ :id ]
            if h2[ :id ] != field_id
              puts "!! ERROR: field id mismatch - expected #{h2[ :id ]}; got #{field_id}:"
              pp field
              exit 1
            end
         else
           h2[ :id ] = field_id
         end

         if comparative
           h2[ :comparative ] ||= 0
           h2[ :comparative ] += 1
         end

         (field['subfields'] || []).each do |subfield|
           subfields = h2[ :subfields ] ||= {}

           name        = subfield['name']

           h3 = subfields[ name ] ||= { count: 0, codes: [] }

           h3[ :count ] += 1

           ## delete codes if larger (treshhold) than x (e.g. 9)
           h3.delete( :codes )    if h3[ :count ] > 9

           h3[ :codes ] << code.code   if h3[ :codes ]   ## note: might got deleted if passed treshhold (e.g. 9 entries)
         end
      end
  end
end



pp counter


### save to json
puts "saving a copy to fields.json for debugging"
File.open( "pages/json/fields.json", 'w:utf-8' ) do |f|
  f.write JSON.pretty_generate( counter )
end


