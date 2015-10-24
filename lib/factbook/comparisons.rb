# encoding: utf-8

module Factbook

class Comparisons

  Comparison = Struct.new( :num,        ### todo: use no or id or something - why? why not?
                           :category,  ## e.g. Geography, People, Economy, etc.
                           :name,
                          )

  def self.from_csv( path )

    rows = CSV.read( path, headers: true )
    
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

    self.new( recs )
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

