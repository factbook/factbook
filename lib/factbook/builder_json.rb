# encoding: utf-8

module Factbook

######
# json builder -- lets us rebuild a page from "dumped" json (instead of parsing html page)

class JsonBuilder    
  include LogUtils::Logging


def self.from_file( path )
  text = File.read( path )     ## fix: use File.read_utf8  from textutils
  self.from_string( text )
end

def self.from_string( text )
  self.new( text )
end


attr_reader :text,
            :json,
            :page_info,       ## not used yet -- incl. country_name, region_name, last_updated etc.
            :errors,          ## not used yet -- encoding erros etc.
            :sects


def initialize( text )
  @text = text
    
  @json = JSON.parse( text )

  @page_info = nil   ## fix/todo: sorry - for now no page info (use header in json - why? why not??)
  @errors = []       ## fix/todo: sorry - for now no errors possible/tracked

  @sects = []

  @json.each do |k1,v1|
    sect_title    = k1
    sect_subsects = v1
    
    sect = Sect.new
    sect.title = sect_title
    
    ## get subsections
    subsects = []
    sect_subsects.each do |k2,v2|
      subsect_title = k2
      subsect_data  = v2
      
      subsect = Subsect.new
      subsect.title = subsect_title
      subsect.data  = subsect_data
      
      subsects << subsect
    end
    
    sect.subsects = subsects
    @sects << sect
  end
end

end # class JsonBuilder


end # module Factbook
