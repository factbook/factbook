###
#  use to run:
#   ruby update2/profile.rb


require_relative 'helper'



def read_profile( cty )
  json = Webcache.read( cty.data_url )
  data = JSON.parse( json )

  data = convert_cia( data )
  data

  profile = Factbook::Profile.parse( data )
  profile
end


outdir = '../country-profiles'
# outdir = './tmp/profiles'


codes = Factbook.codes

# ['au', 'be', 'mx', 'us'].each do |code|
#  cty = codes[ code ]

 codes.each do |cty|
  profile = read_profile( cty )
  ## pp profile


  puts profile.size
  # puts profile[0].size                ## e.g. Introduction/Background
  # puts
  # puts profile['Introduction']['Background']['text']
  # puts profile['Geography']['Location']['text']
  # puts profile['Geography']['Area']['total']['text']


  puts "profile:"
  buf = String.new('')
  buf << "_#{cty.region} / #{cty.category}_\n\n"
  buf << "# #{cty.name}\n\n"

  buf << profile.to_markdown
  puts buf[0..200]

  puts "slugs:"
  puts cty.region_slug
  puts cty.name_slug

  outpath = "#{outdir}/#{cty.region_slug}/#{cty.name_slug}.md"

  ## make sure path exits
  FileUtils.mkdir_p( File.dirname( outpath ) )  unless File.exist?( File.dirname( outpath ) )


  ## note: (auto-)convert to unix newlines only => e.g. universal (e.g. gsub( "\r\n", "\n" ))
  File.open( outpath, 'w:utf-8', :newline => :universal ) { |f| f.write( buf ) }
end

puts "bye"

