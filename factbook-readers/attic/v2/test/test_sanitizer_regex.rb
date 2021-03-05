###
#  to run use
#     ruby -I ./lib -I ./test test/test_sanitizer_regex.rb


require 'helper'


class TestSanitizerRegex < MiniTest::Test

  def test_area_map

html =<<HTML
<div class='disTable areaComp'>
<span class='category tCell' style='margin-bottom:0px; vertical-align:bottom;'>Area comparison map:</span>
<span class="tCell"><a data-toggle="modal" href="#areaCompModal"><img src="../graphics/areacomparison_icon.jpg" border="0" style="cursor:pointer; border: 0px solid #CCC;"></a></span></div>

        <div class="modal fade" id="areaCompModal" role="dialog">
             <div class="wfb-modal-dialog">
                <div class="modal-content"  >
                   <div class="wfb-modal-header" style="border-radius: 4px; font-family: Verdana,Arial,sans-serif; font-size: 14px !important; font-weight: bold;  padding: 0.4em 16px 0.4em 1em; background: #cccccc url("..images/ui-bg_highlight-soft_75_cccccc_1x100.png") repeat-x scroll 50% 50%;" >
                      <span style="font-size: 14px !important; margin: 0.1em 16px 0.1em 0;" class="modal-title wfb-title">The World Factbook</span><span style="float: right; margin-top: -4px;">
                      <button type="button" class="close" title="close" data-dismiss="modal">&times;</button></span>
                    </div>
                   <div class="wfb-modal-body">
...
<div id='field'
HTML

   m = Factbook::Sanitizer::AREA_COMP_CATEGORY_REGEX.match( html )
   pp m

   assert m.nil? == false
  end


  def test_pop_pyramid

html =<<HTML
<div class='disTable popPyramid'>
<span class='category tCell' style='margin-bottom:0px; vertical-align:bottom;'>population pyramid:</span>
<span class="tCell"><a data-toggle="modal" href="#popPyramidModal"><img title="" src="../graphics/poppyramid_icon.jpg" style="cursor:pointer; border: 0px solid #CCC;"></span></a></div>

        <div class="modal fade" id="popPyramidModal" role="dialog">
             <div class="wfb-modal-dialog">
                <div class="modal-content"  >
                   <div class="wfb-modal-header" style="border-radius: 4px; font-family: Verdana,Arial,sans-serif; font-size: 14px !important; font-weight: bold;  padding: 0.4em 16px 0.4em 1em; background: #cccccc url("..images/ui-bg_highlight-soft_75_cccccc_1x100.png") repeat-x scroll 50% 50%;" >
                      <span style="font-size: 14px !important; margin: 0.1em 16px 0.1em 0;" class="modal-title wfb-title">The World Factbook</span><span style="float: right; margin-top: -4px;">
                      <button type="button" class="close" title="close" data-dismiss="modal">&times;</button></span>
                    </div>
                   <div class="wfb-modal-body">
...
<div id='field'
HTML

   m = Factbook::Sanitizer::POP_PYRAMID_CATEGORY_REGEX.match( html )
   pp m

   assert m.nil? == false
 end  # method test_pop_pyramid


  def test_rel_affiliation

html =<<HTML
<div class='disTable relAffiliation'><span class='category tCell' style='margin-bottom:0px; vertical-align:bottom;'>religious affiliation:</span>
<span class="tCell"><a data-toggle="modal" href="#relAffiliationModal"><img title="" src="../graphics/middle-east-religion-icon.jpg" style="cursor:pointer; border: 0px solid #CCC;"></span></a></div>

        <div class="modal fade" id="relAffiliationModal" role="dialog">
           <div class="wfb-modal-dialog">
              <div class="modal-content"  >
                 <div class="wfb-modal-header" style="border-radius: 4px; font-family: Verdana,Arial,sans-serif; font-size: 14px !important; font-weight: bold;  padding: 0.4em 16px 0.4em 1em; background: #cccccc url("..images/ui-bg_highlight-soft_75_cccccc_1x100.png") repeat-x scroll 50% 50%;" >
                    <span style="font-size: 14px !important; margin: 0.1em 16px 0.1em 0;" class="modal-title wfb-title">The World Factbook</span><span style="float: right; margin-top: -4px;">
                    <button type="button" class="close" title="close" data-dismiss="modal">&times;</button></span>
                 </div>
                 <div class="wfb-modal-body">
...
<div id='field'
HTML

     m = Factbook::Sanitizer::REL_AFFILIATION_CATEGORY_REGEX.match( html )
     pp m

     assert m.nil? == false
  end # method test_rel_affiliation

end # class TestSanitizerRegex
