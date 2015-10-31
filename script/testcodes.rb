# encoding: utf-8
#
#  use to run/test:
#   ruby -I ./lib script/testcodes.rb

require 'factbook'

Factbook.codes.each do |code|
  pp code
end

