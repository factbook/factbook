

module Factbook

class Attributes

  Attribute = Struct.new( :name,
                          :category,  ## e.g. Introduction, Geography, etc.
                          :path,      ## note: is an array  e.g. ["Area - comparative"] or ["Area", "land"] etc.
                        )

  def self.read_yaml( path )

    h = YAML.load_file( path )
    pp h

    attribs = []

    ## note: use a copy (e.g. h.dup) for now (hash gets changed by build_attribs!!)
    new_h = h.dup
    new_h.each do |k,v|
      category = k
      build_attribs( attribs, category, [], v )
    end

    new( attribs )
  end


  def self.build_attribs( attribs, category, path, h )

      ## assume it's an attribute definition hash
      ##   note: !! exclude special cases:
      ##      Capital           -- incl. name key itself
      ##      National anthem
     if h.has_key?( 'name' ) &&  ['Capital','National anthem'].include?( path[-1] ) == false
       a = Attribute.new
       a.name     = h['name']
       a.category = category
       a.path     = path

       puts "  adding attribute >#{a.name}< using #{a.category} / #{a.path.inspect}"
       attribs << a

       ## note: make sure a modifable copy (of h) gets passed in
       h.delete( 'name' )
     end

     return  if h.empty?    ## empty hash; nothing (more) to do; return

     ## continue walking (recursive)
     h.each do |k,v|
       new_path = path.dup << k   ## note: create a new array (copy)
       build_attribs( attribs, category, new_path, v )
    end
  end


  def initialize( attribs )
    @attribs = attribs
  end

  def to_a() @attribs; end
  def size() @attribs.size; end

  def each
    @attribs.each { |attrib| yield( attrib ) }
  end

end  # class Attributes

end # module Factbook

