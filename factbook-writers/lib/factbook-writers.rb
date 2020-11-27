## stdlibs
require 'cgi'
require 'erb'     ## used by Almanac class (for render)


## our own code
require 'factbook-readers/attributes'


## note: make attributes available
module Factbook
  ##  note: load on demand only builtin attributes, etc.
  ##          for now
  def self.attributes
    @@attributes  ||= Attributes.read_yaml( "#{Factbook::Module::Writers.root}/data/attributes.yml" )
  end

class Page
  ## add convenience (shortcut) accessors / attributes / fields / getters
  Factbook.attributes.each do |attrib|
    ## e.g.
    ##    def background()  data['Introduction']['Background']['text']; end
    ##    def location()    data['Geography']['Location']['text'];      end
    ##    etc.
    if attrib.path.size == 1
      define_method( attrib.name.to_sym ) do
        @data.fetch( attrib.category, {} ).
              fetch( attrib.path[0], {} )['text']
      end
    else  ## assume size 2 for now
      define_method( attrib.name.to_sym ) do
        @data.fetch( attrib.category, {} ).
              fetch( attrib.path[0], {} ).
              fetch( attrib.path[1], {} )['text']
      end
    end
  end
end # class Page
end # module Factbook


require 'factbook-readers/almanac'


