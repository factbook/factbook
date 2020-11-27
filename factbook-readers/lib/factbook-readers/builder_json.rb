
module Factbook

######
# json builder -- lets us rebuild a page from "dumped" json (instead of parsing html page)

class JsonBuilder
  include LogUtils::Logging
  include NormalizeHelper    ##  e.g. normalize_category


attr_reader :text,
            :json,
            :info,            ## not used yet -- page info incl. country_name, region_name, last_updated etc.
            :errors,          ## not used yet -- encoding erros etc.
            :sects


def initialize( text )
  @text = text

  @json = JSON.parse( text )

  @info   = nil   ## fix/todo: sorry - for now no page info (use header in json - why? why not??)
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

      #####
      ## note: run data hash through normalize_category (again)
      if subsect_data.is_a?( Hash )
        new_subsect_data = {}
        subsect_data.each do |k3,v3|
          new_subsect_data[ normalize_category(k3) ] = v3
        end
        subsect_data = new_subsect_data
      end

      subsect.data  = subsect_data

      subsects << subsect
    end

    sect.subsects = subsects
    @sects << sect
  end
end

end # class JsonBuilder


end # module Factbook
