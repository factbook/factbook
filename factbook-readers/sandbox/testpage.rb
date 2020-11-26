$LOAD_PATH.unshift( './lib' )
require 'factbook'

code = 'co'
url = "https://www.cia.gov/library/publications/the-world-factbook/geos/#{code}.html"

html = Webcache.read( url )
pp html[0..100]


##    note: </p    => unclosed p!! change to </p>

  ## note: in regex use negative looakhead e.g. (?!patttern)
  html = html.gsub( %r{</p(?![>])} ) do |m|
    puts "!! WARN: fixing unclosed </p => </p>"
    puts "#{m}"
    '</p>'
  end



doc = Nokogiri::HTML( html )

ul = doc.css( 'ul.expandcollapse' )[0]

puts ul.to_html[0..100]

File.open( 'tmp/co.html', 'w:utf-8') { |f| f.write( ul.to_html ) }

  ##  filter all li's
  ul_children = ul.children.select { |el| if el.name == 'li'
                                             true
                                          else
                                            puts "skipping #{el.name} >#{el.to_html}<"
                                            false
                                          end
                                    }
  puts "  #{ul_children.size} li(s):"

  lis = ul.css( 'li' )
  puts "  #{lis.size} li(s):"



Factbook::Sanitizer.new.sanitize( html )


puts "bye"


__END__

<ul class="expandcollapse">
      <li id="introduction-category-section-anchor">
        <a href="#"
  4 li(s):
 2 div(s):
  [debug ] unwrap <p> no.1
 10 div(s):
  [debug ] unwrap <p> no.1
!! ERROR: div (W/O category_data class) in >Area - comparative<:
<div class="category soa_light" style="padding-left:5px;" id="field-anchor-geography-land-boundaries">
      <span class="btn-tooltip definition" role="tooltip" aria-hidden="true">
        <a aria-label="Use this link to access a description of the Land boundaries field" href="../docs/notesanddefs.html#281">Land boundaries</a>:
        <span class="tooltip-content">
            This entry contains the total length of all land boundaries and the individual lengths for each of the contiguous border countries. When available, official lengths published by national statistical agencies are used. Because surveying methods may differ, country border lengths reported by contiguous countries may differ.
        </span>
      </span>
      <span class="field-listing-link">
          <a href="../fields/281.html#CO"><img alt="Land boundaries field listing" title="Land boundaries field listing" src="../images/field_listing.gif"></a>
      </span>
  </div>