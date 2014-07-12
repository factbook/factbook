require 'hoe'
require './lib/factbook/version.rb'

Hoe.spec 'factbook' do

  self.version = Factbook::VERSION

  self.summary = 'factbook - scripts for the world factbook (get open structured data e.g JSON etc.)'
  self.description = summary

  self.urls = ['https://github.com/worlddb/factbook.ruby']

  self.author = 'Gerald Bauer'
  self.email = 'openmundi@googlegroups.com'

  # switch extension to .markdown for gihub formatting
  self.readme_file = 'README.md'
  self.history_file = 'HISTORY.md'

  self.extra_deps = [
    ['logutils' ],
    ['fetcher'],
    ['nokogiri']
  ]

  self.licenses = ['Public Domain']

  self.spec_extras = {
   :required_ruby_version => '>= 1.9.2'
  }

end



desc 'generate json for factbook.json repo'
task :genjson do
  require 'factbook'

  countries = [
    'au',
    'be',
    'br',
    'mx',
    'us'
  ]

  countries.each do |country|
     gen_json_for( country )
  end
end


def gen_json_for( code )
  Dir.mkdir( 'tmp' )       unless Dir.exists?( 'tmp' )
  Dir.mkdir( 'tmp/html' )  unless Dir.exists?( 'tmp/html' )
  Dir.mkdir( 'tmp/json' )  unless Dir.exists?( 'tmp/json' )

  page = Factbook::Page.new( code )    

  ## print first 600 chars
  pp page.html[0..600]

  ## save for debuging
    
  puts "saving a copy to #{code}.html for debugging"
  File.open( "tmp/html/#{code}.html", 'w') do |f|
      f.write( page.html )
  end

  h = page.data
  pp h
    
  ### save to json
  puts "saving a copy to #{code}.json for debugging"
  File.open( "tmp/json/#{code}.json", 'w') do |f|
    f.write( JSON.pretty_generate( h ) )
  end
end

