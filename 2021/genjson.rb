###
#  (re)generate json datasets from (cached) datasets


require_relative 'boot'


##
##  todo: mae region_to_slug into a utility method for (re)use - how, why? why not??
def region_to_slug( text )
  ##  change and  =>  n
  ##  change  &   =>  n
  ##  change all spaces to => -
  ##   e.g. East & Southeast Asia          => east-n-southeast-asia
  ##        Central America and Caribbean  => central-america-n-caribbean
  text.downcase.gsub('and', 'n').gsub( '&', 'n' ).gsub( ' ', '-' )
end


def convert_cia( cia )

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



def _gen_json( out_root:, converter: nil )
  ## for debugging select some codes
  ## codes = Factbook.codes.select {|code| ['us','au'].include?(code.code) }

  codes = Factbook.codes

  i = 0
  codes.each do |code|
    puts "[#{i+1}/#{codes.size}]:"
    pp code

    if code.code == 'wi'  ## 404 Not found --   Western Sahara no longer available??
      ## skip -- do nothing
    else
      url = "https://www.cia.gov/the-world-factbook/geos/#{code.code}.json"

      json = Webcache.read( url )
      data = JSON.parse( json )

      region_slug = region_to_slug( code.region )
      path = "#{out_root}/#{region_slug}/#{code.code}.json"

      FileUtils.mkdir_p( File.dirname( path ) )    ## make sure path exist

      data = converter.call( data )  if converter

      puts "Saving #{code.code}- #{code.name} to >#{path}<..."
      ## note: (auto-)convert to unix newlines only => e.g. universal (e.g. gsub( "\r\n", "\n" ))
      File.open( path, 'w:utf-8', :newline => :universal ) do |f|
        f.write( JSON.pretty_generate( data ) )
      end
    end

    i += 1
  end

  puts "done - saved in (#{out_root})"
end



def gen_json1
  out_root =  if debug?
                './tmp/json1'
              else
                 Mononame.real_path( 'cache.factbook.json@factbook' )
              end

  _gen_json( out_root: out_root )
end


def gen_json2
  out_root =  if debug?
                './tmp/json2'
              else
                 Mononame.real_path( 'factbook.json@factbook' )
              end

  _gen_json( out_root: out_root,
             converter: ->(data) { convert_cia( data ) } )
end

