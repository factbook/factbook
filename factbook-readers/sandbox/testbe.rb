$LOAD_PATH.unshift( './lib' )
require 'factbook/readers'

page = Factbook::Page.new( 'be' )
pp page.data                        # pretty print hash



__END__


url = 'https://www.cia.gov/library/publications/the-world-factbook/geos/cc.html'

html = Webcache.read( url )
pp html[0..100]


Factbook::Sanitizer.new.sanitize( html )


__END__

doc = Nokogiri::HTML( html )

ul = doc.css( 'ul.expandcollapse' )[0]

puts ul.to_html[0..100]

File.open( 'tmp/cc.html', 'w:utf-8') { |f| f.write( ul.to_html ) }
