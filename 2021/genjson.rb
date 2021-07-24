###
#  (re)generate json datasets from (cached) datasets


require_relative 'boot'



def _gen_json( out_root:, converter: nil )
  ## for debugging select some codes
  ## codes = Factbook.codes.select {|code| ['us','au'].include?(code.code) }

  codes = Factbook.codes

  i = 0
  codes.each do |code|
    puts "==> [#{i+1}/#{codes.size}] #{code.format}:"

      json = Webcache.read( code.data_url )
      data = JSON.parse( json )

      path = "#{out_root}/#{code.region_slug}/#{code.code}.json"

      FileUtils.mkdir_p( File.dirname( path ) )    ## make sure path exist

      data = converter.call( data )   if converter

      puts "Saving #{code.code} - #{code.name} to >#{path}<..."
      ## note: (auto-)convert to unix newlines only => e.g. universal (e.g. gsub( "\r\n", "\n" ))
      File.open( path, 'w:utf-8', :newline => :universal ) do |f|
        f.write( JSON.pretty_generate( data ) )
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



#######################
## for testing use:
##   ruby 2021/genjson.rb

if __FILE__ == $0
  _gen_json( out_root: './tmp/json2',
             converter: ->(data) { convert_cia( data ) } )
end
