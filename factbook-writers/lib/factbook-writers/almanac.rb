# encoding: utf-8

module Factbook


class Almanac

  ## convenience helper ("factory") 
  def self.from_json( codes, json_dir: '.' )
    pages = JsonPageReader.new( json_dir ).read_pages( codes )
    self.new( pages )
  end


  def initialize( pages )
    @pages = pages
  end

  def render( template )
    buf = ''
    @pages.each do |page|
      text = PageCtx.new( page, template ).render

      puts text     ## for debugging write country profile to console (too)
      buf << text
    end
    puts "count: #{@pages.count}"
    buf   ## return buffered almanac text
  end


class PageCtx
  attr_accessor :page

  def initialize(page, template)
    @page     = page
    @template = template
  end

  ##############################
  ## add some "view helpers"

  def name
    ##  -- calculate name (use long name if (short) name is not availabe e.g. none)
    ##   e.g. Austria
    if @name.nil?
      @name = page.name
      @name = page.name_long  if @name == 'none'
    end
    @name
  end

  def names( separator: ' • ' )
    ##  e.g. Austria • Österreich
    if @names.nil?
      if page.name_local.blank? || page.name_local == 'none' || page.name_local == name
        @names = [name]    ## no local (in its own non-english language) name
      else
        @names = [name, page.name_local]
      end
    end
    @names.join( separator )
  end

  def render
    ERB.new( @template).result( binding )
  end
end   ## PageCtx

end ## Almanac

end # module Factbook
