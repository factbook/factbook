
module Factbook

## todo/check: change to PageMeta/ProfileMeta
##   or Page/ProfileMetaInfo or MetaInfo or Meta or such - why? why not?


### was before 2021 (when using html page scrapping)
# PageInfo = Struct.new( :country_code,
#                          :country_name,
#                          :country_affiliation,
#                          :region_code,
#                          :region_name,
#                          :last_updated )

PageInfo = Struct.new( :country_code,
                       :country_name,
                       :region_name,
                       :published,   ## note: published is NOT before updated (like an alias for created) BUT is often older/later than updated - why!?
                       :updated )


end # module Factbook
