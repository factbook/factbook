
module Factbook

## todo/check: change to ProfileMeta
##   or ProfileMetaInfo or MetaInfo or Meta or such - why? why not?



ProfileInfo = Struct.new( :country_code,
                          :country_name,
                          :country_affiliation,
                          :region_code,
                          :region_name,
                         :last_updated )

end # module Factbook
