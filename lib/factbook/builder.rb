# encoding: utf-8

module Factbook

class Builder     ## todo: change to PageBuilder ???
  include LogUtils::Logging


=begin
def self.from_cc( cc, opts={} )  ## rename to from_file_for_country() or from_file_for_cc() or something - why?? why not??
  ## check/todo: rename input_dir to just dir or to include ?
  ##   (there's no output_dir)?? - why? why not?
  input_dir = opts[:input_dir] || '.'
  self.from_file( "#{input_dir}/#{cc}.html" )
end
=end


def self.from_file( path )
  html_ascii = File.read( path )    ## fix/todo: use ASCII8BIT/binary reader !!!!!
  self.from_string( html_ascii )
end

def self.from_string( html_ascii )   ## note: expects ASCII-7BIT/BINARY encoding
  self.new( html_ascii )
end


attr_reader :html_ascii,     ## full "original" 1:1 page in "original/ascii8/binary" encoding
            :html,           ## utf-8 encoded profile
            :html_debug,     ## html w/ mapping markers - rename to html_markers - why? why not?
            :info,            ## page info incl. country_name, region_name, last_updated etc.
            :errors,          ## encoding erros etc.
            :sects


def initialize( html_ascii )
  @html_ascii = html_ascii

  ## todo/fix: use/assume windows 12xx?? encoding - change encoding to utf-8  (from binary/ascii8bit)
  @html, @info, @errors = Sanitizer.new.sanitize( @html_ascii )


  html_sects =  if @html.empty?
                   ## note: support "empty" pages - old format waiting for update!!!
                   ##    cannot parse for now
                   []  ## return empty (no) sections for now - sorry (its just one page with code cc anyway!!)
                else
                   @html_debug = map_sects( @html )
                   @html_debug = map_subsects( @html_debug )

                   split_sects( @html_debug )
                end

  pp html_sects

  ## debug
  ## File.open( 'tmp/br.debug.html', 'w:utf-8') { |f| f.write( @html_debug ) }


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

  self  ## return self -- needed?? default (standard) anyway?? check and remove
end



def map_sects( html )
   ## convert section titles to "unified" marker
   ## e.g.
   ##   <h2>Introduction</h2>

  title_regex= /<h2>
                 \s*
                   (.+?)  ## note: use non-greedy; do NOT allow tags inside for now
                 \s*
                <\/h2>
              /xim

  html = html.gsub( title_regex ) do |m|
     puts "** found section >#{$1}<:"
     puts "   >|#{m}|<"

     "\n\n@SECTION{#{$1}}\n\n"
  end
  html
end


def map_subsects( html )
   ## convert subsection titles to "unified" marker
   ## e.g.
   ##  <h3>Disputes - international:</h3>

  title_regex= /<h3>
                  \s*
                   (.+?)                ## note: use non-greedy; allows tags inside - why? why not
                  \s*
                 <\/h3>
               /xim

  html = html.gsub( title_regex ) do |m|
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

  section_regex= /(@SECTION{.+?})/  ## note: use non-greedy -- check: need to escape {} ??

  chunks = html.split( section_regex )

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

  subsection_regex= /(@SUBSECTION{.+?})/  ## note: use non-greedy -- check: need to escape {} ??

  chunks = html.split( subsection_regex )

  ## check if first item is a section or (html) prolog
  #   if prolog (remove)
  chunks.slice!(0)  unless chunks[0] =~ /@SUBSECTION/  ## starts w/ @SUBSECTION

  pairs = chunks.each_slice(2).to_a
  pairs
end

end # class Builder


end # module Factbook
