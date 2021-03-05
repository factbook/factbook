## 3rd party gems/libs
## require 'props'

require 'logutils'
require 'csvreader'



# our own code
require 'factbook-codes/version' # let it always go first


module SportDb
  Logging = LogUtils::Logging     ## logging machinery shortcut; use LogUtils for now
end


require 'factbook-codes/codes'


## note: make codes available
module Factbook
  ##  note: load on demand only builtin codes, comparisons, etc.
  ##          for now
  def self.codes
    @@codes ||= Codes.read_csv( "#{Factbook::Module::Codes.root}/data/codes.csv" );
  end

  ## let's put test configuration in its own namespace / module
  class Test    ## todo/check: works with module too? use a module - why? why not?
    ####
    #  todo/fix:  find a better way to configure shared test datasets - why? why not?
    #    note: use one-up (..) directory for now as default - why? why not?
    def self.data_dir()        @data_dir ||= '../testdata'; end
    def self.data_dir=( path ) @data_dir = path; end
  end
end # module Factbook





puts Factbook::Module::Codes.banner
