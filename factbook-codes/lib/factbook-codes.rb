## 3rd party gems/libs
## require 'props'

require 'logutils'
require 'csvreader'



# our own code
require 'factbook-codes/version' # let it always go first

require 'factbook-codes/codes'


## note: make codes available
module Factbook
  ##  note: load on demand only builtin codes, comparisons, etc.
  ##          for now
  def self.codes
    @@codes       ||= Codes.read_csv( "#{Factbook::Module::Codes.root}/data/codes.csv" );
  end
end # module Factbook


puts Factbook::Module::Codes.banner
