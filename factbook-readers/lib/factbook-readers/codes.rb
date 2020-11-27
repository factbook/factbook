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

  def self.read_csv( path )
    ###
    #  note:
    #   if you use quotes - NO leading spaces allowed e.g.
    #  use au,"Austria",... and NOT
    #      au, "Austria", ...
    #
    #  for headers - NO leading spaces allowed e.g.
    #   use  Code,Name,Category,Region,...   and NOT
    #        Code, Name, Category, Region, ...

    rows = CsvHash.read( path )

    pp rows

    recs = []
    rows.each do |row|
      pp row
      rec = Code.new
      rec.code     = row['Code'].strip    ## remove leading n trailing whitespaces
      rec.name     = row['Name'].strip

      ## note: for now category and region are optional
      rec.category = row['Category'].strip   if row['Category'] && row['Category'].size > 0
      rec.region   = row['Region'].strip     if row['Region'] && row['Region'].size > 0

      pp rec
      recs << rec
    end

    new( recs )
  end


  def initialize( codes )
    @codes = codes
  end

  def size() @codes.size; end

  def each( &blk ) @codes.each( &blk ); end
  def select( &blk )
    codes = @codes.select( &blk )
    Codes.new( codes )   ## return (again) new Codes obj for easy-chaining - why? why not?
  end


  def to_a
    @codes.collect {|code| code.code }   ## return array of codes
  end

  ##  def all()  self.to_a; end    ## note: alias for to_a - use - why? why not??

  ## "pre-defined" convenience shortcuts
  def countries()       category 'Countries';     end
  def world()           category 'World';         end
  def oceans()          category 'Oceans';        end
  def misc()            category 'Miscellaneous'; end
  def others()          category 'Other';         end
  def dependencies()    category 'Dependencies';  end
  def dependencies_us() category 'Dependencies (United States)'; end
## fix/todo: add all dependencies  uk (or gb?), fr,cn,au,nz,no,dk,etc.

  def europe()               region 'Europe';            end
  def south_asia()           region 'South Asia';        end
  def central_asia()         region 'Central Asia';      end
  def east_n_souteast_asia() region 'East & Southeast Asia'; end
  def middle_east()          region 'Middle East';       end
  def africa()               region 'Africa';            end
  def north_america()        region 'North America';     end
  def central_america_n_caribbean() region 'Central America and Caribbean'; end
  def south_america()        region 'South America';     end
  def australia_oceania()    region 'Australia-Oceania'; end
  def antartica()            region 'Antarctica';        end

  ## note: regions oceans and world - same as category oceans and world
  ##     use oceans_ii or world_ii or something ??
  ##   use category('World')  n region('World')
  ##   use category('Oceans') n region('Oceans')


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

