# encoding: utf-8

##
# note:
#   the factbook category/region for world is other entities (on FAQ) and oceans in page
#    changed to world


module Factbook

class Codes

  Code = Struct.new( :code,      ## todo: add notes (country affiliation) - why? why not??
                     :name,
                     :category,  ## e.g. Countries, Other, Oceans, World, Dependencies, etc.
                     :region,    ## e.g. Europe, Oceans, etc.
                    )

  def self.from_csv( path )
    ###
    #  note:
    #   if you use quotes - NO leading spaces allowed e.g.
    #  use au,"Austria",... and NOT
    #      au, "Austria", ...
    #
    #  for headers - NO leading spaces allowed e.g.
    #   use  Code,Name,Category,Region,...   and NOT
    #        Code, Name, Category, Region, ...

    rows = CSV.read( path, headers: true )
    
    pp rows

    recs = []
    rows.each do |row|
      pp row
      rec = Code.new
      rec.code     = row['Code'].strip    ## remove leading n trailing whitespaces
      rec.name     = row['Name'].strip

      ## note: for now category and region are optional
      rec.category = row['Category'].strip   if row ['Category']
      rec.region   = row['Region'].strip      if row['Region']  

      pp rec
      recs << rec
    end

    self.new( recs )
  end

  def initialize( codes )
    @codes = codes
  end
  
  def size() @codes.size; end

  def each
    @codes.each {|code| yield( code ) }
  end

  def to_a
    @codes.collect {|code| code.code }   ## return array of codes
  end

  ##  def all()  self.to_a; end    ## note: alias for to_a - use - why? why not??

  ## "pre-defined" convenience shortcuts
  def countries()       category( 'Countries' );     end
  def world()           category( 'World' );         end
  def oceans()          category( 'Oceans' );        end
  def misc()            category( 'Miscellaneous' ); end
  def others()          category( 'Other' );         end
  def dependencies()    category( 'Dependencies' );  end
  def dependencies_us() category( 'Dependencies (United States)' ); end

  def europe()          region( 'Europe' ); end

  ###
  ##  todo: fix add region e.g. Europe,Asia,Oceans, etc.


  def category( query )
    ## todo/future: allow passing in of regex too (not just string)
    ## note: e.g. Dependencies (France) needs to get escpaed to
    ##            Dependencies \(France\)  etc.
    filter_regex = /#{Regexp.escape(query)}/i
    codes = @codes.select do |code|
      code.category ? filter_regex.match( code.category ) : false   ## note: allow nil for category; will fail on search
    end
    Codes.new( codes )   ## return new Codes obj for easy-chaining
  end

  def region( query )
    ## todo/future: allow passing in of regex too (not just string)
    filter_regex = /#{Regexp.escape(query)}/i
    codes = @codes.select do |code|
       code.region ? filter_regex.match( code.region ) : false      ## note: allow nil for region; will fail on search
    end
    Codes.new( codes )   ## return new Codes obj for easy-chaining
  end

end  # class codes

end # module Factbook

