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

html = ul.to_html

###
## sanitize

## remove link items
##   assume two <li>s are a section

html = String.new('')

##  filter all li's
ul_children = ul.children.select { |el| if el.name == 'li'
                                           true
                                        else
                                          # puts "skipping #{el.name} >#{el.to_html}<"
                                          false
                                        end
                                  }
puts "  #{ul_children.size} li(s):"
ul_children.each_slice(2) do |lis|
  li  = lis[0]
  div = li.at( 'div[sectiontitle]' )

  html << "<h2>#{div['sectiontitle']}</h2>\n"


  li  = lis[1]
  ## filter all div's
  li_children = li.children.select { |el| if el.name =='div'
                                              true
                                          else
                                           # puts "skipping #{el.name} >#{el.to_html}<"
                                           false
                                          end
                                    }
  puts " #{li_children.size} div(s):"

  li_children.each_slice(2) do |divs|
    div = divs[0]
    a = div.css('a')[0]

    if a
      html << "\n<h3>#{a.text}:</h3>\n"
    else
      puts "!! WARN: no anchor found:"
      puts div.to_html
    end


    div = divs[1]
    div_children = div.children.select {|el| el.name == 'div' ? true : false }
    div_children.each do |catdiv|
       if catdiv['class'] && catdiv['class'].index( 'category_data' )

        if catdiv['class'].index( 'attachment' )
          ## skip attachments e.g. maps, pop pyramids, etc.
        else
          html << catdiv.to_html
          html << "\n"
        end
       else
        puts "!! WARN: skipping div (W/O category_data class):"
        puts catdiv.to_html
       end
    end
  end
end


#
#  <span class="subfield-date" aria-label="Date of information: 2018">(2018)</span>
#
#  remove aria labels
ARIA_ATTR_REGEX = /\s*
                     aria-label=('|").+?\1     ## note: use non-greedy match e.g. .+?
                   /xim    ## do NOT allow multi-line - why? why not?

html = html.gsub( ARIA_ATTR_REGEX ) do |m|
  puts "remove aria-label attr:"
  puts "#{m}"
  ''
end


File.open( 'tmp/br.y.html', 'w:utf-8') { |f| f.write( html ) }


puts "bye"

__END__






## <h2 sectiontitle='Introduction' ccode='ag'>
##   Introduction ::  <span class='region'>ALGERIA </span>
## </h2>
##   becomes =>
## <h2>Introduction</h2>

# <div class="question soa_med" sectiontitle="Geography" ccode="br" style="border-bottom: 2px solid white;">
# Geography ::  <span class="region">Brazil</span>
# </div>

ul.css( 'div[sectiontitle]' ).each do |div|
  puts "replace section >#{div['sectiontitle']}<:"
  div.to_html

  div.replace( "<h2>#{div['sectiontitle']}</h2>" )
end

##
## <div id='field' class='category'>Electricity - consumption:</div>
##   becomes =>
## <h3>Electricity - consumption:</h3>

ul.css( 'div.category' ).each do |div|
  a = div.css('a')[0]
  puts "replace subsection >#{a.text}<"
  div.to_html

  div.replace( "<h3>#{a.text}:</h3>" )
end



File.open( 'tmp/br.x.html', 'w:utf-8') { |f| f.write( ul.to_html ) }

__END__



=begin
STYLE_ATTR_REGEX = /\s*
                     style=('|").+?\1     ## note: use non-greedy match e.g. .+?
                   /xim    ## do NOT allow multi-line - why? why not?

html = html.gsub( STYLE_ATTR_REGEX ) do |m|
  puts "remove style attr:"
  puts "#{m}"
  ''
end
=end


##
##  <div class='wrap'>
##     <div class='audio-player'>
##    <audio id='audio-player-1' class='my-audio-player' src='../anthems/AU.mp3' type='audio/mp3' controls='controls'>
##    </audio>
##  </div></div>


AUDIO_PLAYER_REGEX = /
        <div \s class='wrap'>
        <div \s class='audio-player'>
          <audio \s [^>]+>
          <\/audio>
        <\/div>
        <\/div>
         /xim



html = html.gsub( AUDIO_PLAYER_REGEX ) do |m|
  puts "remove audio player:"
  puts "#{m}"
  ''
end

##
## <div>
##    <span class='category'>country comparison to the world:  </span>
##    <span class='category_data'>[[191]]</span>
## </div>
##
##  <span class='category'>country comparison to the world:  </span>
##  <span class='category_data'><a href='../rankorder/2147rank.html#au'>114</a></span>
##
## <div>
##  <span class="category">country comparison to the world:</span>
##  <span class="category_data">
##     <a href="../fields/353rank.html#BR">88</a>
## </span>
## </div>


## todo: add enclosing div too!!!

COUNTRY_COMPARISON_REGEX = /
        <div>
          \s*
         <span \s class="category"[^>]*>
           country \s comparison \s to \s the \s world: \s*
         <\/span>
          \s*
         <span \s class="category_data"[^>]*>
          \s*
            <a \s [^>]+>
             .+?
            <\/a>
          \s*
         <\/span>
          \s*
         <\/div>
        /xim


html = html.gsub( COUNTRY_COMPARISON_REGEX ) do |m|
  puts "remove country comparison:"
  puts "#{m}"
  ''
end




File.open( 'tmp/br.2.html', 'w:utf-8') { |f| f.write( html ) }

