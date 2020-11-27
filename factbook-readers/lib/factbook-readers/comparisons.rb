
module Factbook

class Comparisons

  Comparison = Struct.new( :num,        ### todo: use no or id or something - why? why not?
                           :category,  ## e.g. Geography, People, Economy, etc.
                           :name,
                          )

  def self.read_csv( path )

    rows = CsvHash.read( path )

    pp rows

    recs = []
    rows.each do |row|
      pp row
      rec = Comparison.new
      rec.num      = row['Num'].strip.to_i    ## remove leading n trailing whitespaces
      rec.category = row['Category'].strip
      rec.name     = row['Name'].strip

      pp rec
      recs << rec
    end

    new( recs )
  end

  def initialize( comps )
    @comps = comps
  end

  def size() @comps.size; end

  def each
    @comps.each {|comp| yield( comp ) }
  end

  def to_a
    @comps.collect {|comp| comp.num }   ## return array of nums   -- return something else - why? why not?
  end

end  # class Comparison

end # module Factbook

