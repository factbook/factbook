# encoding: utf-8

module Factbook
  module Utils


BEGIN_FACTS_REGEX = /<ul\s+
                       class="expandcollapse">
                    /xim    ## ignore case; multi-line

END_FACTS_REGEX = /<\/li>\s*
                   <\/ul>\s*
                   <\/tbody>\s*
                   <\/table>
                  /xim      ## ignore case; multi-line


STYLE_ATTR_REGEX = /\s*
                     style=('|").+?\1     ## note: use non-greedy match e.g. .+?
                   /xim    ## do NOT allow multi-line - why? why not?

CLASS_ATTR_REGEX =  /\s*
                     class=('|")(.+?)\1     ## note: use non-greedy match e.g. .+?
                   /xim    ## do NOT allow multi-line - why? why not?

##
## <div>
##    <span class='category'>country comparison to the world:  </span>
##    <span class='category_data'>[[191]]</span>
## </div>
##
##  <span class='category'>country comparison to the world:  </span>
##  <span class='category_data'><a href='../rankorder/2147rank.html#au'>114</a></span>


## todo: add enclosing div too!!!

COUNTRY_COMPARISON_REGEX = /
        <div>
         <span \s class='category'[^>]*>
           country \s comparison \s to \s the \s world: \s*
         <\/span>
          \s*
         <span \s class='category_data'[^>]*>
          \s*
            <a \s [^>]+>
             .+?
            <\/a>
          \s*
         <\/span>
         <\/div>
        /xim

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



def find_country_profile( html )
  ####
  ## remove header (everything before)
  ##   <ul class="expandcollapse">

  pos = html.index( BEGIN_FACTS_REGEX )
  fail "*** no begin facts marker found for page"  if pos.nil?

  puts "  bingo - found BEGIN_FACTS on pos #{pos}"
  html = html[pos..-1]

  pp html[0..100]

  ###
  ## remove footer
  ##  assume everthings after (last list item in unorder list inside a table body)
  ##    </li>
  ##    </ul>
  ##    </tbody></table>

  pos = html.index( END_FACTS_REGEX )
  fail "*** no end facts marker found for page"  if pos.nil?
    
  puts "  bingo - found END_FACTS on pos #{pos}"
  html = html[0...pos] + "</li></ul>\n"        ## note: use ... (not .. to cut-off pos)

  pp html[-200..-1]
  html
end




def sanitize( html )

  html = html.gsub( STYLE_ATTR_REGEX ) do |m|
          puts "remove style attr:"
          puts "#{m}"
          ''
        end

  html = html.gsub( AUDIO_PLAYER_REGEX ) do |m|
          puts "remove audio player:"
          puts "#{m}"
          ''
        end


  html = html.gsub( COUNTRY_COMPARISON_REGEX ) do |m|
          puts "remove country comparison:"
          puts "#{m}"
          ''
        end

  ## remove/cleanup anchors (a href)
  html = html.gsub( /<a\s+href[^>]*>(.+?)<\/a>/im ) do |_|   ## note: use .+? non-greedy match
    puts " replace anchor (a) href >#{$1}<"
    
    inner_text = $1.dup ## keep a copy
    if inner_text =~ /<img/    ## if includes image remove
      puts "  remove image in anchor"
      ''
    else    ## keep inner text
      inner_text
    end
  end


  ## remove all list e.g. ul/li
  html = html.gsub( /<\/?(li|ul)[^>]*>/im ) do |m|
    puts " remove list >#{m}<"
    ''
  end

  ## clean-up class attrib e.g. remove unknown classes
  html = html.gsub( CLASS_ATTR_REGEX ) do |m|
          puts "cleanup class attr:"
          puts "#{m}"
          
          klasses = $2.split(' ')
          klasses = klasses.select do |klass|
            if ['region', 'category', 'category_data'].include?( klass )
              true
            else
              puts "  remove class #{klass}"
              false
            end
          end

          if klasses.size > 0
            " class='#{klasses.join(' ')}'"   ## note: add leading space!!
          else
            ''   ## remove class attrib completely
          end
        end

   html
end


  end   # module Utils
end     # module Factbook
