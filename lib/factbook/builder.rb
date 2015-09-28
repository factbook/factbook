# encoding: utf-8

module Factbook

class Builder
  include LogUtils::Logging
  include Utils     ## pulls in encode_utf8, ...

def self.from_file( cc, opts={} )
  input_dir = opts[:input_dir] || '.'
  html_ascii = File.read( "#{input_dir}/#{cc}.html" )    ## fix/todo: use ASCII8BIT/binary reader
  self.new( cc, html_ascii )
end


attr_reader :cc,
            :html_ascii,     ## full "original" 1:1 page in "original/ascii8/binary" encoding
            :html,           ## utf-8 encoded profile
            :errors,     ## encoding erros etc.
            :last_updated,
            :country_info,
            :html_debug       ## html w/ mapping markers - rename to html_markers - why? why not?


def initialize( cc, html_ascii )
  @cc         = cc
  @html_ascii = html_ascii

  html_profile_ascii = find_country_profile( @html_ascii )    ## cut-off headers, footers, scripts, etc.
    
  @html, @errors = encode_utf8( html_profile_ascii )  ## change encoding to utf-8  (from binary/ascii8bit)

  @html = sanitize( @html )
  
  @last_updated = find_page_last_updated( @html_ascii )
  @country_info = find_country_info( @html_ascii )

  @html_debug = map_sects( @html )
  @html_debug = map_subsects( @html_debug )

  pp split_sects( @html_debug )

end


def map_sects( html )
   ## convert section titles
   ##   from  <h2>..</h2>
   ##   to "unified" marker

  ## e.g.
  ##  <h2 sectiontitle='Introduction' ccode='au'>Introduction ::  <span class='region'>AUSTRIA </span></h2>
  ##  <h2>Introduction</h2>

  title_regex= /<h2
                 (?:\s[^>]+)?  ## allow optional attributes in h2
                 >      
                 \s*
                   ([^<>]+?)  ## note: use non-greedy; do NOT allow tags inside for now
                 \s*
                 (?:\s::\s
                   .+?       ## note: use non-greedy; allows tags inside
                 )?          ## strip optional name (e.g.  :: AUSTRIA)
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
   ## convert subsection titles
   ##   from  <div id='field'>..</div>
   ##   to "unified" marker

  ## e.g.
  ##  <div id='field' class='category'>Disputes - international:</div>

  title_regex= /<div \s id='field'
                     \s class='category'>
                   \s*
                   (.+?)                ## note: use non-greedy; allows tags inside - why? why not
                   \s*
                 <\/div>
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
