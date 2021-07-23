
module Factbook


######
# builder -- lets us rebuild a profile from "dumped" hash

class ProfileBuilder      ## change to DataBuilder or such - why? why not?
  include Logging


attr_reader :profile,
            :errors           ## not used yet -- encoding erros etc.





def initialize( text_or_data )

  data = if text_or_data.is_a?( String )
           text = text_or_data
           JSON.parse( text )
         else  ## assume it's already a hash
            text_or_data
         end


  @profile = Profile.new
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
      field.data  = field_data

      category << field
    end
    @profile << category
  end
end

end # class ProfileBuilder


end # module Factbook
