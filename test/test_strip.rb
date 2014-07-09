# encoding: utf-8


require 'helper'


class TestStrip < MiniTest::Unit::TestCase

  def test_country_comparison

html=<<EOS
  
  <span class="category" style="padding-left:7px;">country comparison to the world:</span> <span class="category_data"> <a href="../rankorder/2147rank.html?countryname=Brazil&countrycode=br&regionCode=soa&rank=5#br" onMouseDown=""  title="Country comparison to the world" alt="Country comparison to the world"> 5 </a> </span>
          
EOS

        ## note: need to escapce space!!!! e.g. use to\s the\s world etc.
        ## Note: To match whitespace in an x pattern use an escape such as \s or \p{Space}.

        country_comparison_regex = /
         <span \s class="category"[^>]*>
           country \s comparison \s to \s the \s world:
         <\/span>
          \s*
         <span \s class="category_data"[^>]*>
          \s*
            <a \s [^>]+>
             .+?
            <\/a>
          \s*
         <\/span>
        /xm

      country_comparison_space_regex = /
           country \s comparison \s to \s the \s world:
        /xm

      country_comparison_span_regex = /
         <span \s class="category"[^>]*>
        /xm

      country_comparison_cat_regex = /
         <span \s class="category"[^>]*>
           country \s comparison \s to \s the \s world:
         <\/span>
        /xm


       m = country_comparison_space_regex.match( html )
       pp m
       assert m    # must find a match

       m = country_comparison_span_regex.match( html )
       pp m
       assert m    # must find a match

       m = country_comparison_cat_regex.match( html )
       pp m
       assert m    # must find a match

       m = country_comparison_regex.match( html )
       pp m
       assert m    # must find a match
  end

end # class TestStrip
