
module Factbook


class ProfileGuideReader
## check: rename to GuideReader or such only - why? why not?
## check: change/rename to profile_tree or profile_hierarchy or _schema or ???? - why? why not?


CATEGORY_RE = /^=[ ]*
                (?<name>[^ ].*)$/x    # e.g.  = Geography
                                      #   or  = People and Society

SUBFIELD_RE = /^-[ ]*
                 (?<name>[^ ].*)$/x   # e.g.   - total
                                      #   or   - border countries
                                      #        etc.



def self.read( path )
  txt = File.open( path, 'r:utf-8') {|f| f.read }
  parse( txt )
end

def self.parse( txt )
  new( txt ).parse
end


def initialize( txt )
  @txt = txt
end

def parse
  data = {}

  category = nil
  field    = nil

  @txt.each_line do |line|
    ## note: line includes newline

    ## strip (optional) inline comments
    ##   todo/check: use index or such such and cut-off substring instead of regex - why? why not?
    line = line.sub( /#.*$/, '' )

    line = line.strip   # remove all leading & trainling spaces incl. newline

    next if line.empty? || line.start_with?('#')   # skip empty lines and comment lines


    if m=CATEGORY_RE.match( line )
      puts "category >#{m[:name]}<"
      category = data[ m[:name] ] = {}
    elsif m=SUBFIELD_RE.match( line )
      puts "    subfield >#{m[:name]}<"
      field << m[:name]
    else   ## assume field
      puts "  field >#{line}<"
      field = category[ line ] = []
    end
  end

  data
end   # method parse

end   # class ProfileGuideReader
end   # module Factbook
