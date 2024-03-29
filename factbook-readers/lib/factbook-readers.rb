require 'factbook-fields'

## more 3rd party gems/libs
## require 'props'
require 'webget'

require 'nokogiri'    ## note: needed for clean-up / sanitize of "raw" json
                      ##   see convert script



# our own code
require 'factbook-readers/version' # let it always go first



require 'factbook-readers/convert'
require 'factbook-readers/page_info'
require 'factbook-readers/page'

require 'factbook-readers/counter'




puts Factbook::Module::Readers.banner
