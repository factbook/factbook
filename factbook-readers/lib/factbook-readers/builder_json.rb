
module Factbook

######
# json builder -- lets us rebuild a page from "dumped" json (instead of parsing html page)

class JsonBuilder
  include LogUtils::Logging
  include NormalizeHelper    ##  e.g. normalize_category


attr_reader :info,            ## not used yet -- page info incl. country_name, region_name, last_updated etc.
            :errors,          ## not used yet -- encoding erros etc.
            :profile


def initialize( text )

  data = JSON.parse( text )

  @profile = Profile.new
  @info    = nil   ## fix/todo: sorry - for now no page info (use header in json - why? why not??)
  @errors  = []       ## fix/todo: sorry - for now no errors possible/tracked


  data.each do |k1,v1|
    category_title    = k1
    category_data     = v1

    category = Category.new( category_title )

    ## get fields
    category_data.each do |k2,v2|
      field_title = k2
      field_data  = v2

      field = Field.new( field_title )

      #####
      ## note: run data hash through normalize_title (again)
      if field_data.is_a?( Hash )
        new_field_data = {}
        field_data.each do |k3,v3|
          new_field_data[ normalize_title(k3) ] = v3
        end
        field_data = new_field_data
      end

      field.data  = field_data

      category << field
    end
    @profile << category
  end
end

end # class JsonBuilder


end # module Factbook
