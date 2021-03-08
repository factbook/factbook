###
#  to run use
#     ruby -I ./lib -I ./test test/test_page.rb


require 'helper'


class TestPage < MiniTest::Test


  def test_pages
    pages = [
      [ 'au', 11 ],
      [ 'be', 11 ],
      [ 'br', 10 ],
#      [ 'ee', 10 ],
#      [ 'mx', 10 ],
#      [ 'xx', 10 ],
#      [ 'ls', 9  ],
#      [ 'vt', 8  ],
      ]

    pages.each do |rec|
        code       = rec[0]
        size       = rec[1]

        path = "#{Factbook::Test.data_dir}/json/#{code}.json"
        page = Factbook::Page.read_json( path )

        assert_equal size, page.size
    end
  end


end # class TestPage
