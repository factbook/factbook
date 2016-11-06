# encoding: utf-8

module Factbook

class Sanitizer
  include LogUtils::Logging
  include Utils     ## pulls in encode_utf8, ...


def sanitize( html_ascii )
  ## todo: add option for (html source) encoding - why?? why not??

  ## note:
  ##   returns 1) html profile withouth headers, footers, scripts,etc.
  ##           2) page (meta) info e.g. country_name, country_code, last_updated, etc.
  ##           3) errors e.g. list of errors e.g. endcoding errors (invalid byte sequence etc.)

  page_info = PageInfo.new

  ## todo:
  ##   make page info optional? why? why not?
  ##   not always available (if page structure changes) - check
  ##   what page info is required??
  h = find_page_info( html_ascii )
  if h
    page_info.country_code        = h[:country_code]
    page_info.country_name        = h[:country_name]
    page_info.country_affiliation = h[:country_affiliation]
    page_info.region_code         = h[:region_code]
    page_info.region_name         = h[:region_name]
  else
    page_info.country_code = find_country_code( html_ascii )
    ## print/warn: no page info found
  end


  page_info.last_updated        = find_page_last_updated( html_ascii )


  html_profile_ascii = find_country_profile( html_ascii )    ## cut-off headers, footers, scripts, etc.

  ## todo/fix: assume windows 12xx encoding!!!! for factbook - try
  html, errors = encode_utf8( html_profile_ascii )  ## change encoding to utf-8  (from binary/ascii8bit)

  html = sanitize_profile( html )

  [html, page_info, errors]
end



####
# example match:
#
#  <ul class="expandcollapse">

BEGIN_FACTS_REGEX = /<ul \s+
                       class="expandcollapse">
                    /xim    ## ignore case; multi-line; ignore space (use \s for space/newline!)


####
# example match:
#
# ++ 2016 Nov/3:
#
#  </li>
#  </ul>
#  <!-- end generated content -->
#
### todo: just use first match of </li></ul> - why? why not?
#
# history/changes:
# ++ 2015 Sept/24   (for regex see attic):
#
#  </li>
#  </ul>
#  </tbody></table>
#


END_FACTS_REGEX = /<\/li> \s*
                   <\/ul> \s*
                   <!-- \s end \s generated \s content \s -->
                  /xim      ## ignore case; multi-line; ignore space (use \s for space/newline!)


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


## remove category => Area comparison map:
##
##  <div class='disTable areaComp'
##   ...
##  until hitting: <div id='field'    -- e.g. next category/field (use lookahead e.g. (?=))

AREA_COMP_CATEGORY_REGEX = /
    <div \s class='disTable \s areaComp'
      .+?
    (?=<div \s id='field')
  /xim


## remove category => population pyramid:
##
## <div class='disTable popPyramid'>
##  ...
## until hitting: <div id='field'    -- e.g. next category/field (use lookahead e.g. (?=))

POP_PYRAMID_CATEGORY_REGEX = /
    <div \s class='disTable \s popPyramid'
      .+?
    (?=<div \s id='field')
  /xim

## remove category => religious affiliation:
##
## <div class='disTable relAffiliation'>
##  ...
## until hitting: <div id='field'    -- e.g. next category/field (use lookahead e.g. (?=))

REL_AFFILIATION_CATEGORY_REGEX = /
      <div \s class='disTable \s relAffiliation'
        .+?
      (?=<div \s id='field')
    /xim





def sanitize_profile( html )

  ## remove categories w/ visualizations/graphics only e.g.
  ##  - area comparions map
  ##  - population pyramid
  ##  - religious affiliation

  html = html.gsub( AREA_COMP_CATEGORY_REGEX ) do |m|
          puts "remove category => area comparison map:"
          puts "#{m}"
          ''
        end

  html = html.gsub( POP_PYRAMID_CATEGORY_REGEX ) do |m|
          puts "remove category => population pyramid:"
          puts "#{m}"
          ''
        end

  html = html.gsub( REL_AFFILIATION_CATEGORY_REGEX ) do |m|
          puts "remove category => religious affiliation:"
          puts "#{m}"
          ''
        end

  ################################################
  ## more - let's get started

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
  html = html.gsub( /<a\s+[^>]+>(.+?)<\/a>/im ) do |_|   ## note: use .+? non-greedy match
    puts " replace anchor (a) >#{$1}<"

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


end # class Sanitizer

end # module Factbook
