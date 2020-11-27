
module Factbook

class Sanitizer
  include LogUtils::Logging
  include Utils   ## e.g. find_page_info etc.

def sanitize( html )
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
  h = find_page_info( html )
  if h
    page_info.country_code        = h[:country_code]
    page_info.country_name        = h[:country_name]
    page_info.country_affiliation = h[:country_affiliation]
    page_info.region_code         = h[:region_code]
    page_info.region_name         = h[:region_name]
  else
    page_info.country_code = find_country_code( html )
    ## print/warn: no page info found
  end


  page_info.last_updated  = find_page_last_updated( html )


  html_profile = find_country_profile( html )    ## cut-off headers, footers, scripts, etc.

  ## todo/check: remove 3rd args old errors array - why? why not?
  [html_profile, page_info, []]
end



def find_country_profile( html )
  ####
  ## remove header (everything before)
  ##   <ul class="expandcollapse">

  ##
  ## fix know broken html bugs
  ##  in co (Columbia) page (Nov/11 2020):
  ## <div class="photogallery_captiontext">
  ##   <p>slightly less than twice the size of Texas</p
  ## </div>
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
  ## ul_children = ul.css( 'li' )

  puts "  #{ul_children.size} li(s):"
  ul_children.each_slice(2) do |lis|
    li  = lis[0]
    div = li.at( 'div[sectiontitle]' )
    if div.nil?
      puts "!! ERROR: no section title found in div:"
      puts li.to_html
      exit 1
    end

    section_title = div['sectiontitle'].to_s

    html << "<h2>#{section_title}</h2>\n"


    li  = lis[1]
    ## filter all div's
    li_children = li.children.select { |el| if el.name =='div'
                                                true
                                            else
                                             # puts "skipping #{el.name} >#{el.to_html}<"
                                             false
                                            end
                                      }
    puts " #{li_children.size} div(s) in >#{section_title}<:"


    ## check special case in world  Geographic overview:
#    <div class="category oce_light" style="padding-left:5px;"
#       id="field-anchor-geography-geographic-overview">
#           Geographic overview:
#       <span class="field-listing-link">
#            <a href="../fields/275.html#XX">
#              <img alt="Geographic overview field listing"
#                   title="Geographic overview field listing"
#                   src="../images/field_listing.gif" /></a>
#         </span>
#</div>
# vs regular
#
# <div class="category oce_light" style="padding-left:5px;"
#       id="field-anchor-geography-area-comparative">
#      <span class="btn-tooltip definition" role="tooltip" aria-hidden='true'>
 #       <a aria-label="Use this link to access a description of the Area - comparative field"
 #            href="../docs/notesanddefs.html#280">
 #            Area - comparative
 #         </a>:
 #       <span class="tooltip-content">
 #           This entry provides an area comparison based on total area equivalents. Most entities are compared with the entire US or one of the 50 states based on area measurements (1990 revised) provided by the US Bureau of the Census. The smaller entities are compared with Washington, DC (178 sq km, 69 sq mi) or The Mall in Washington, DC (0.59 sq km, 0.23 sq mi, 146 acres).
 #       </span>
 #     </span>
  #    <span class="field-listing-link">
  #        <a href="../fields/280.html#XX"><img alt="Area - comparative field listing" title="Area - comparative field listing" src="../images/field_listing.gif" /></a>
  #    </span>
  # </div>

    li_children.each_slice(2) do |divs|
      div = divs[0]

      ## try new way - try clean-up / rm first
      span_tooltip_content = div.at( 'span.tooltip-content' )
      if span_tooltip_content
        span_tooltip_content.inner_html = ''
        span_tooltip_content.replace( '' )  ## check for how to delete/remove - why? why not!!
      end

      span_field_listing_link = div.at( 'span.field-listing-link' )
      if span_field_listing_link
        span_field_listing_link.inner_html = ''
        span_field_listing_link.replace( '' )
      end

      subsection_title = div.text.strip
      html << "\n<h3>#{subsection_title}</h3>\n"

      # a = div.css('a')[0]
      # if a
      #  subsection_title = a.text   ## todo/check/rename: use field_name or such - why? why not?
      #  html << "\n<h3>#{subsection_title}:</h3>\n"
      # else
      #  subsection_title = '???'
      #  puts "!! WARN: no anchor found:"
      #  puts div.to_html
      # end


      div = divs[1]
      div_children = div.children.select {|el| el.name == 'div' ? true : false }
      puts "   #{div_children.size} div(s) in field >#{subsection_title}<:"

      ## use more robust version - only get divs with category_data
      ## div_children = div.css( 'div.category_data' )
      ## puts "   #{div_children.size} div(s) in field >#{subsection_title}< v2:"

      # if div_children.size > 14
      #  ## us labor force has 11 divs
      #  ## possibly an error
      #  puts "!! ERROR - too many category_data divs found:"
      #  puts div.to_html[0..200]
      #  puts "\n...\n"
      #  puts puts div.to_html[-400..-1]
      #  exit 1
      # end

      div_children.each do |catdiv|
         if catdiv['class'] && catdiv['class'].index( 'category_data' )

          if catdiv['class'].index( 'attachment' )
            ## skip attachments e.g. maps, pop pyramids, etc.
          else
            html << sanitize_data( catdiv, title: subsection_title )
            html << "\n"
          end
         else
            if catdiv.to_html.index( 'country comparison to the world' )
              ## silently skip for now country comparision
            else
              puts "!! ERROR: div (W/O category_data class) in >#{subsection_title}<:"
              puts catdiv.to_html
              exit 1
            end
         end
      end
    end
  end

  html
end


#
#  <span class="subfield-date" aria-label="Date of information: 2018">(2018)</span>
#
#  remove aria labels
ARIA_ATTR_RE = /\s*
                     aria-label=('|").+?\1     ## note: use non-greedy match e.g. .+?
                  /xim    ## do NOT allow multi-line - why? why not?

## find double breaks e.g. <br><br>
BR_BR_RE = /(<br> \s* <br>)
              /xim   ## do NOT allow multi-line - why? why not?


def sanitize_data( el, title: )
  ## todo/fix/check:
  ##  check if more than one p(aragraph)
  ##    get squezzed together without space inbetween?


  ## step 0: replace all possible a(nchor) links with just inner text
  el.css( 'a').each do |a|
     a.replace( " #{a.text.strip} " )
  end



  inner_html = String.new('')

  ## step 1 - unwrap paragraphs if present
  ##          and convert dom/nokogiri doc/tree to html string
  p_count = 0
  el.children.each do |child|
    if child.name == 'p'
      ## puts "  [debug ] unwrap <p> no.#{p_count+1}"

      p_inner_html = child.inner_html.strip  ## note: unwrap! use inner_html NOT to_html/html
      if p_inner_html.empty?
        ## note: skip empty paragraphs for now
      else
        inner_html << ' ++ '    if p_count > 0
        inner_html << p_inner_html
        inner_html << " \n\n "

        p_count += 1
      end
    else
      inner_html << child.to_html
    end
  end
  ## note: keep container div!! just replace inner html!!!
  ##  note: right strip all trailing spaces/newlines for now
  ##        plus add back a single one for pretty printing

  ## note: replace all non-breaking spaces with spaces for now
  ##  see fr (france) in political parties section for example
  ##  todo/check/fix:  check if we need to use unicode char!! and NOT html entity
  inner_html = inner_html.gsub( "&nbsp;", ' ' )
  ## Unicode Character 'NO-BREAK SPACE' (U+00A0)
  inner_html = inner_html.gsub( "\u00A0", ' ' )  ## use unicode char


  el.inner_html = inner_html.rstrip + "\n"

  # finally - convert back to html (string)
  html = el.to_html



  html = html.gsub( ARIA_ATTR_RE ) do |m|
    ## do not report / keep silent for now
    ## puts "in >#{title}< remove aria-label attr:"
    ## puts "#{m}"
    ''
  end

  html = html.gsub( BR_BR_RE ) do |m|
    puts "in >#{title}< squish two <br>s into one:"
    puts "#{m}"
    '<br>'
  end

  html = html.gsub( /<br>/i ) do |m|
    puts "in >#{title}< replace <br> with inline (plain) text ++:"
    puts "#{m}"
    ' ++ '
  end

  ## cleanup/remove ++   before subfield e.g.
  ##  of: ++   => of:    or such
  ##
  ##  todo/fix: add negative lookahead e.g. not another + to be more specific!!
  html = html.gsub( %r{
                       (?<=([a-z]:)|(:</span>))  # note: use zero-length positive lookbehind
                          \s+
                          \+{2}}xim ) do |m|
     puts "in >#{title} remove ++ before <field>: marker:"
     puts "#{m}"
    ' '
  end

  #####
  # "unfancy" smart quotes to ascii - why? why not?
  # e.g.
  #   Following Britain’s victory => Following Britain's victory
  html = html.tr( "’", "'" )
  #   “full floor” House vote     => "full floor" House vote
  html = html.tr( "“”", '""' )

  html
end



end # class Sanitizer

end # module Factbook
