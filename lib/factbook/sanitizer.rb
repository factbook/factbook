
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


 #
  #  <span class="subfield-date" aria-label="Date of information: 2018">(2018)</span>
  #
  #  remove aria labels
  ARIA_ATTR_REGEX = /\s*
                       aria-label=('|").+?\1     ## note: use non-greedy match e.g. .+?
                     /xim    ## do NOT allow multi-line - why? why not?


def find_country_profile( html )
  ####
  ## remove header (everything before)
  ##   <ul class="expandcollapse">

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


  html = html.gsub( ARIA_ATTR_REGEX ) do |m|
    puts "remove aria-label attr:"
    puts "#{m}"
    ''
  end

  html
end


end # class Sanitizer

end # module Factbook
