###
#  to run use
#     ruby -I ./lib -I ./test test/test_version.rb

require 'helper'


class TestVersion < MiniTest::Test

  def test_version
    pp Factbook::Module::Readers.root
    pp Factbook::Module::Readers.banner
  end

end # class TestVersion
