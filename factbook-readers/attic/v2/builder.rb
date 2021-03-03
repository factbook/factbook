
module Factbook

class Builder     ## todo: change to HtmlBuilder or PageBuilder ???
  include LogUtils::Logging



attr_reader :html_original,    ## full "original" 1:1 page
            :html,             ## cut-out and sanitized profile
            :html_debug,      ## html w/ mapping markers - rename to html_markers - why? why not?
            :info,            ## page info incl. country_name, region_name, last_updated etc.
            :errors,          ## encoding erros etc.
            :sects


def initialize( html_original )
  @html_original = html_original

  @html, @info, @errors = Sanitizer.new.sanitize( @html_original )


  html_sects =  if @html.empty?
                   ## note: support "empty" pages - old format waiting for update!!!
                   ##    cannot parse for now
                   @html_debug = ''
                   []  ## return empty (no) sections for now - sorry (its just one page with code cc anyway!!)
                else
                   @html_debug = map_sects( @html )
                   @html_debug = map_subsects( @html_debug )

                   split_sects( @html_debug )
                end

  pp html_sects

  ## debug
  ##   File.open( 'tmp/br.debug.html', 'w:utf-8') { |f| f.write( @html_debug ) }


  @sects = []
  html_sects.each do |html_sect|
    html_sect_head = html_sect[0]
    html_subsects  = html_sect[1]
    puts html_sect_head
    puts html_subsects.size

    ## get section title
    ##  @SECTION{Economy}  => Economy
    if html_sect_head =~ /@SECTION{(.+?)}/
      title = $1.strip
      puts title
      sect = Sect.new
      sect.title = title
      ## get subsections
      subsects = []
      html_subsects.each do |html_subsect|
        html_subsect_head = html_subsect[0]
        html_subsect_body = html_subsect[1]
        if html_subsect_head =~ /@SUBSECTION{(.+?)}/
          title = $1.strip
          title = title.sub( /:\z/, '' )    # remove trailing : if present
          title = title.strip

          puts title
          subsect = Subsect.new
          subsect.title = title     ## todo/fix: cut off trailing colon (:)

          b = Factbook::ItemBuilder.new( html_subsect_body, title )
          h = b.read
          subsect.data = h

          subsects << subsect
        else
          ## warn/fix: no subsection title found
        end
      end
      sect.subsects = subsects
      @sects << sect
    else
      ## warn/fix:  no section title found
    end
  end
end


H2_RE = /<h2>
          \s*
         (.+?)  ## note: use non-greedy; do NOT allow tags inside for now
          \s*
         <\/h2>
        /xim

def map_sects( html )
   ## convert section titles to "unified" marker
   ## e.g.
   ##   <h2>Introduction</h2>

  html = html.gsub( H2_RE ) do |m|
     puts "** found section >#{$1}<:"
     puts "   >|#{m}|<"

     "\n\n@SECTION{#{$1}}\n\n"
  end
  html
end


H3_RE = /<h3>
          \s*
         (.+?)                ## note: use non-greedy; allows tags inside - why? why not
          \s*
        <\/h3>
       /xim

def map_subsects( html )
   ## convert subsection titles to "unified" marker
   ## e.g.
   ##  <h3>Disputes - international:</h3>

  html = html.gsub( H3_RE ) do |m|
     puts "** found subsection >#{$1}<:"
     puts "   >|#{m}|<"

     "\n@SUBSECTION{#{$1}}\n"
  end
  html
end



def split_sects( html )
  ####
  #  split html in sections (divided by section headings)
  #  e.g. remove optional prolog ??,
  ##   [[heading,sect],
  ##    [heading,sect],
  ##    [heading,sect],...]

  ## note: "wrap" regex in a capture group (just one)
  ##   String#split will include all catpure groups in the result array

  ## note: use non-greedy -- check: need to escape {} ??
  chunks = html.split( /(@SECTION{.+?})/ )

  ## check if first item is a section or (html) prolog
  #   if prolog (remove)
  chunks.slice!(0)  unless chunks[0] =~ /@SECTION/  ## starts w/ @SECTION

  pairs = chunks.each_slice(2).to_a

  ## now split subsections
  newpairs = []
  pairs.each do |item|
    ## todo: after cleanup prolog; remove @SECTION{} ?? - just keep title - why, why not??
    newpairs << [item[0], split_subsects( item[1]) ]
  end
  newpairs
end


def split_subsects( html )
  ####
  #  split html in subsections (divided by subsection headings)
  #  e.g. remove optional prolog ??,
  ##   [[heading,sect],
  ##    [heading,sect],
  ##    [heading,sect],...]

  ## note: "wrap" regex in a capture group (just one)
  ##   String#split will include all catpure groups in the result array

  ## note: use non-greedy -- check: need to escape {} ??
  chunks = html.split( /(@SUBSECTION{.+?})/ )

  ## check if first item is a section or (html) prolog
  #   if prolog (remove)
  chunks.slice!(0)  unless chunks[0] =~ /@SUBSECTION/  ## starts w/ @SUBSECTION

  pairs = chunks.each_slice(2).to_a
  pairs
end

end # class Builder


end # module Factbook
