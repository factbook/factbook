# encoding: utf-8


require 'helper'


class TestPage < MiniTest::Unit::TestCase

  def test_mx
    page = Factbook::Page.new( 'mx' )
    
    ## print first 600 chars
    pp page.html[0..600]
    
    doc = page.doc

    panels    = doc.css( '.CollapsiblePanel' )
    questions = doc.css( '.question' )
    answers   = doc.css( '.answer' )

    puts "panels.size:    #{panels.size}"
    puts "questions.size: #{questions.size}"
    puts "answers.size:   #{answers.size}"

    cats0      = panels[0].css( '.category' )
    cats0_data = panels[0].css( '.category_data' )

    puts "cats0.size:       #{cats0.size}"
    puts "cats0_data.size:  #{cats0_data.size}"

    cats1      = panels[1].css( '.category' )
    cats1_data = panels[1].css( '.category_data' )

    puts "cats1.size:       #{cats1.size}"
    puts "cats1_data.size:  #{cats1_data.size}"


    ## fix: use cats -- add s
    cat = doc.css( '#CollapsiblePanel1_Geo div.category' )
    puts "cat.size: #{cat.size}"

    catcheck = doc.css( '#CollapsiblePanel1_Geo .category' )
    puts "catcheck.size: #{catcheck.size}"

    catcheck2 = doc.css( '.category' )
    puts "catcheck2.size: #{catcheck2.size}"


    catdata = doc.css( '#CollapsiblePanel1_Geo .category_data' )
    puts "catdata.size: #{catdata.size}"

    catdatacheck2 = doc.css( '.category_data' )
    puts "catdatacheck2.size: #{catdatacheck2.size}"

    puts "catdata[0]:"
    pp catdata[0]

    puts "catdata[1]:"
    pp catdata[1]

#    puts "catdata[2]:"
#    pp catdata[2]

#    puts "catdata[0].text():"
#    pp catdata[0].text()

#    puts "cat[0].text():"
#    pp cat[0].text()

#    cat.each_with_index do |c,i|
#      puts "[#{i+1}]: ========================="
#      puts ">>#{c.text()}<<"
#    end

  end


end # class TestPage
