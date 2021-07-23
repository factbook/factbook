##
# note:
#   the factbook category/region for world is other entities (on FAQ) and oceans in page
#    changed to world


module Factbook

##  check: move region_to_slug into a utility module / helper
##              for (re)use - how, why? why not??
def self.region_to_slug( text )
  ##  change and  =>  n
  ##  change  &   =>  n
  ##  change all spaces to => -
  ##   e.g. East & Southeast Asia          => east-n-southeast-asia
  ##        Central America and Caribbean  => central-america-n-caribbean
  text.downcase.gsub('and', 'n').gsub( '&', 'n' ).gsub( ' ', '-' )
end



class Codes
  class Code   ## nested class
    ## todo/check: make class "top-level" / not-nested - why? why not?

    ## note: make "value object" read-only for now
    attr_reader :code,      ## todo: add notes (country affiliation) - why? why not??
                :name,
                :category,  ## e.g. Countries, Other, Oceans, World, Dependencies, etc.
                :region    ## e.g. Europe, Oceans, etc.

    def initialize( code:, name:, category:, region: )
      @code     = code
      @name     = name
      @category = category
      @region   = region
    end

    ## todo/check: add aliases e.g. - why? why not?
    ##    country_code => code
    ##    country_name => name
    ##    region_name  => region

    def region_slug() Factbook.region_to_slug( @region ); end


    #################
    ## more helpers

    def data_url  ## add json_url alias or such - why? why not?
      "https://www.cia.gov/the-world-factbook/geos/#{@code}.json"
    end

    def url( format=:json )  ## make html the default - why? why not?
      ## todo/check: use code.json_url or url( :json) or such - why? why not?
       case format
       when :json then data_url
       else  raise ArgumentError, "unknown url format #{format}; expected :json"
       end
    end
  end # (nested) class Code





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

    ## pp rows

    recs = []
    rows.each do |row|
      ## pp row
      rec = Code.new(
        code:     row['Code'].strip,    ## remove leading n trailing whitespaces
        name:     row['Name'].strip,
        category: row['Category'].strip,
        region:   row['Region'].strip
      )

      ## pp rec
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


  def [](key) @codes[ key ]; end

  def to_a
    @codes.collect {|code| code.code }   ## return array of codes
  end

  ##  def all()  self.to_a; end    ## note: alias for to_a - use - why? why not??


  def categories   ## tally up all categories and return category name/count pairs (hash)
     @@categories ||= begin
                         @codes.reduce( Hash.new(0) ) do |categories,code|
                           categories[ code.category ] += 1
                           categories
                         end
                      end
  end

  ## "pre-defined" convenience shortcuts by category
  def countries()       category 'Countries';     end
  def world()           category 'World';         end
  def oceans()          category 'Oceans';        end
  def misc()            category 'Miscellaneous'; end
  def others()          category 'Other';         end
  def dependencies()    category 'Dependencies';  end
  def dependencies_us() category 'Dependencies (United States)'; end
## fix/todo: add all dependencies  uk (or gb?), fr,cn,au,nz,no,dk,etc.



  def regions  ## tally up all regions and return region name/count pairs (hash)
    @@regions ||= begin
                    @codes.reduce( Hash.new(0) ) do |regions,code|
                      regions[ code.region ] += 1
                      regions
                    end
                  end
  end

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

