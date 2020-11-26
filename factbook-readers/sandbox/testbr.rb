require 'pp'
require 'nokogiri'
require 'webget'



url = 'https://www.cia.gov/library/publications/the-world-factbook/geos/br.html'

html = Webcache.read( url )
pp html[0..100]


doc = Nokogiri::HTML( html )

ul = doc.css( 'ul.expandcollapse' )[0]

puts ul.to_html[0..100]

File.open( 'tmp/br.html', 'w:utf-8') { |f| f.write( ul.to_html ) }


