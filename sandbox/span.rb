require 'nokogiri'

 ## !! 6 tag(s): {"span"=>6}

 span =<<HTML
 <span class="ILfuVd"><span class="e24Kjd">Mostly flat to dissected, undulating plains; hills in the west and southeast.&nbsp; </span></span>Occupies an <span class="ILfuVd"><span class="e24Kjd">extensive plateau with s</span></span><span class="ILfuVd"><span class="e24Kjd">avanna that is grassy in the north and gradually gives way to sparse forests in the south.</span></span> (2019)
HTML


def unwrap_recurse( node )
  # depth first so we don't accidentally modify a collection while
  # we're iterating through it.
  node.elements.each do |child|
    unwrap_recurse( child )
  end

  # replace this element's children with it's grandchildren
  # assuming it meets all the criteria
  if node.name == 'span'
    ## puts unwrapp span tag:
    pp node
    node.replace( node.inner_html )
  end
end


doc = Nokogiri::HTML::fragment( span )

span_ii = doc.to_html

puts span
puts "---"
puts span_ii
puts  span == span_ii

=begin
doc.css('span').each do |el|
  puts "before:"
  pp el
  el.replace( el.inner_html )
  puts "after:"
  pp el.inner_html
end
=end

unwrap_recurse( doc )


puts "--- <span>s unwrapped"
puts doc.to_html

puts "bye"

