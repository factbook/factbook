
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


  html = find_country_profile( html_ascii )    ## cut-off headers, footers, scripts, etc.

  ## todo/fix: assume windows 12xx encoding!!!! for factbook - try
  # html, errors = encode_utf8( html_profile_ascii )  ## change encoding to utf-8  (from binary/ascii8bit)

  # html = sanitize_profile( html )

  [html, page_info, []]
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


  ## note: replace all non-breaking spaces with spaces for now
  ##  see fr (france) in political parties section for example
  html = html.gsub( "&nbsp;", ' ' )



  doc = Nokogiri::HTML( html )

  ul = doc.css( 'ul.expandcollapse' )[0]

  puts ul.to_html[0..100]



  ## note: special case cc uses h2 instead of div block
  ##  <h2 class="question cam_med" sectiontitle="Introduction" ccode="cc"
  ##         style="border-bottom: 2px solid white; cursor: pointer;">
  ##         Introduction ::  <span class="region">CURACAO </span>
  ##   </h2>
  ##   is old format !!!!
  ##   cc - CURACAO
  ##  http headers says - last-modified: Wed, 14 Nov 2018 14:09:28 GMT
  ##   page says - PAGE LAST UPDATED ON MARCH 14, 2018
  ##    wait for new version to be generated / pushed!!!

  ## check for old format if h2 are present
  h2s = ul.css( 'h2' )
  if h2s.size > 0
    puts "  !! WARN: found #{h2s.size} h2(s) - assume old format - sorry - must wait for update!!!"
    ## return empty html string - why? why not?
    return  ''
  end


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

    li_children.each_slice(2) do |divs|
      div = divs[0]
      a = div.css('a')[0]

      if a
        subsection_title = a.text   ## todo/check/rename: use field_name or such - why? why not?
        html << "\n<h3>#{subsection_title}:</h3>\n"
      else
        subsection_title = '???'
        puts "!! WARN: no anchor found:"
        puts div.to_html
      end


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
ARIA_ATTR_REGEX = /\s*
                     aria-label=('|").+?\1     ## note: use non-greedy match e.g. .+?
                  /xim    ## do NOT allow multi-line - why? why not?

## find double breaks e.g. <br><br>
BR_BR_REGEX = /(<br> \s* <br>)
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
  el.inner_html = inner_html.rstrip + "\n"

  # finally - convert back to html (string)
  html = el.to_html



  html = html.gsub( ARIA_ATTR_REGEX ) do |m|
    ## do not report / keep silent for now
    ## puts "in >#{title}< remove aria-label attr:"
    ## puts "#{m}"
    ''
  end

  html = html.gsub( BR_BR_REGEX ) do |m|
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
  html = html.gsub( %r{
                       (?<=([a-z]:)|(:</span>))  # note: use zero-length positive lookbehind
                          \s+
                          \+{2}
                          \s+}xim ) do |m|
     puts "in >#{title} remove ++ before <field>: marker:"
     puts "#{m}"
    ' '
  end

  #####
  # "unfancy" smart quotes to ascii - why? why not?
  # e.g.
  # Following Britain’s victory => Following Britain's victory
  html = html.tr( "’", "'" )


  html
end



end # class Sanitizer

end # module Factbook
