# Todos


- [ ]  use Factbook terminology  - why? why not?
       - change subsection to field!!
       - change categories.csv to fields.csv (keep name as it is field name now not wrongly category name)
       - change structs too!! - use Section => Category, Subsection => Field



## Add 4(?) attachment (blocks) too?

- Audio -   in ??  / National anthem
- PDF - total population growth rate v. urban population growth rate in  ?? / ??
- JPG - population pyramid in ?? / ??
- JPG - Area comparison map   in ?? / ??

<!-- break -->

Audio   in  ??  / National anthem

```
      <div class="category_data attachment">
          <audio type="audio/mp3"
                  controls="controls"
                  alt="National Anthem audio file for Austria"
                  src="../attachments/audios/original/AU.mp3?1538604749">
         </audio>
      </div>
```

PDF - total population growth rate v. urban population growth rate
in  ?? / ??

```
    <div class="category_data attachment">
          <span class="subfield-name">
            total population growth rate v. urban population growth rate, 2000-2030:
         </span>

          <a style="display: inline-block; margin-left: 5px; vertical-align: middle" target="_blank" aria-hidden="true"
            href="../attachments/docs/original/urban_AU.pdf?1602698564">
             <img style="height:22px;opacity:.5" src="../images/adobe.png" alt="Adobe" />
         </a>
          <a style="display: inline-block; margin-left: 5px; vertical-align: middle" target="_blank" class="sr-only"
            href="../attachments/docs/original/urban_AU.pdf?1602698564">PDF
         </a>
      </div>
```


JPG - population pyramid in ?? / ??

```
      <div class="category_data attachment">
          <span class="subfield-name">population pyramid:</span>
          <a data-toggle="modal" href="#imageModal5161" class='category_image_link'>
            <img alt="population pyramid" src="../attachments/images/thumb/AU_popgraph2020.JPG?1584126705" />
          </a>
          <div class="modal fade cntryModal" id="imageModal5161" role="dialog"
     aria-label='modal dialog used to display image(s) associated with a field'
     aria-labelledby='imageModalLabel'>
  <div class="wfb-modal-dialog">
    <div class="modal-content">
      <div class="wfb-modal-header">
	<span class="modal-title wfb-title">The World Factbook</span>
        <span class='sr-only' id='imageModalLabel'>Field Image Modal</span>
	<span style="float: right; margin-top: -4px;">
	  <button type="button" class="close" title="close" data-dismiss="modal">×</button>
	</span>
      </div>
      <div class="wfb-modal-body">
	<div class="region1 geos_title eur_dark">
   	    Europe <strong>::</strong>
	  <span class="region_name1 countryName">Austria</span>
          <span class="btn-print">
            <a href="../attachments/images/original/AU_popgraph2020.JPG?1584126705">
              <i class="fa fa-print" aria-hidden='true'></i>
              <span class='sr-only'>Print</span>
            </a>
          </span>
	</div>
	<div class="eur_bkgrnd">
	  <div class="modalImageBox">
	    <img class="eur_lgflagborder"
		 src="../attachments/images/original/AU_popgraph2020.JPG?1584126705" alt="population pyramid">
	  </div>
	  <div class="modalImageDesc">
	    <div class="header"
		 style="background-image: url(../images/eur_medium.jpg)">
	      Image Description
	    </div>
	    <div class="photogallery_captiontext">
	      This is the population pyramid for Austria. A population pyramid illustrates the age and sex structure of a country's population and may provide insights about political and social stability, as well as economic development. The population is distributed along the horizontal axis, with males shown on the left and females on the right. The male and female populations are broken down into 5-year age groups represented as horizontal bars along the vertical axis, with the youngest age groups at the bottom and the oldest at the top. The shape of the population pyramid gradually evolves over time based on fertility, mortality, and international migration trends. <br/><br/>For additional information, please see the entry for Population pyramid on the Definitions and Notes page under the References tab.
	    </div>
	  </div>
	</div>
      </div>
    </div>
  </div>
</div>
```


JPG - Area comparison map   in ?? / ??

```
      <div class="category_data attachment">
          <span class="subfield-name">Area comparison map:</span>
          <a data-toggle="modal" href="#imageModal3974" class='category_image_link'>
            <img alt="Area comparison map" src="../attachments/images/thumb/AU_area.jpg?1548765584" />
          </a>
          <div class="modal fade cntryModal" id="imageModal3974" role="dialog"
     aria-label='modal dialog used to display image(s) associated with a field'
     aria-labelledby='imageModalLabel'>
  <div class="wfb-modal-dialog">
    <div class="modal-content">
      <div class="wfb-modal-header">
	<span class="modal-title wfb-title">The World Factbook</span>
        <span class='sr-only' id='imageModalLabel'>Field Image Modal</span>
	<span style="float: right; margin-top: -4px;">
	  <button type="button" class="close" title="close" data-dismiss="modal">×</button>
	</span>
      </div>
      <div class="wfb-modal-body">
	<div class="region1 geos_title eur_dark">
   	    Europe <strong>::</strong>
	  <span class="region_name1 countryName">Austria</span>
          <span class="btn-print">
            <a href="../attachments/images/original/AU_area.jpg?1548765584">
              <i class="fa fa-print" aria-hidden='true'></i>
              <span class='sr-only'>Print</span>
            </a>
          </span>
	</div>
	<div class="eur_bkgrnd">
	  <div class="modalImageBox">
	    <img class="eur_lgflagborder"
		 src="../attachments/images/original/AU_area.jpg?1548765584" alt="Area comparison map">
	  </div>
	  <div class="modalImageDesc">
	    <div class="header"
		 style="background-image: url(../images/eur_medium.jpg)">
	      Image Description
	    </div>
	    <div class="photogallery_captiontext">
	      <p>about the size of South Carolina; slightly more than two-thirds the size of Pennsylvania</p>
	    </div>
	  </div>
	</div>
      </div>
    </div>
  </div>
</div>






## More


in france (fr) check with `++` is inside of strong tab and not before/outside ???

```
<div class="category_data note">
      <strong>note: </strong>applies to metropolitan France only; for its overseas regions the time difference is UTC-4 for Guadeloupe and Martinique, UTC-3 for French Guiana, UTC+3 for Mayotte, and UTC+4 for Reunion<strong> ++ etymology: </strong>nam
```


- [x] unfancy quotes in text e.g.

```
Following Britain’s victory
=>
Following Britain's victory
```


## strip trailing newslines from data item

see ItemBuilder - strip trailing spaces/newlines ??

see Algeria/Religion for an example with trailing newlines ??


## xx.json  - world page

map reference:

- use squeeze to pretty print text e.g.

- remove newlines and extra spaces; now text() looks like

```
"text":
  "Political Map of the World , Physical Map of the World , 
   Standard Time\n    Zones of the World , World Oceans"
```

instead of

```
"text":
  "Political Map of the World, Physical Map of the World, 
   Standard Time Zones of the World, World Oceans"
```

## Newlines in Fields ?

### Algeria • Al Jaza'ir

check - includes trailing newslines? - why? strip?

```
**Religions** Muslim (official; predominantly Sunni) 99%, other (includes Christian and Jewish)

```


### More Old Todo Notes to Check

```
https://www.cia.gov/library/publications/resources/the-world-factbook/docs/history.html

http://jmatchparser.sourceforge.net/factbook/
  print
  plus print mysql schema

http://ports.gnu-darwin.org/databases/wfb2sql/work/wfb2sql-0.6/doc/wfb2sql.html
   print !!!!!!

``Cyprus'' does not contain correct values for some entries since all values consist of two values:
on for the ``Greek Cypriot area'' and one for the ``Turkish Cypriot area''.
 Maybe this data should be handled manually.

http://jmatchparser.sourceforge.net/factbook/
   see schema / mysql schema db


The MONDIAL Database - Database and Information Systems
www.dbis.informatik.uni-goettingen.de/Mondial/


add
  http://wfb2sql.sourceforge.net/  !!
wfb2sql is a Perl script that extracts information from the CIA World Factbook
and creates SQL statements for IBM DB/2, PostgreSQL or MySQL.
 This data builds a perfect database for learning and teaching SQL.
  check perl script!!!

see
  https://github.com/sayem/worldfactbook/blob/master/lib/worldfactbook/country.rb
  add know shortcuts  e.g   page.gdp   page.pdp_ppp  etc ??
   print worldfactbook readme!!

create list of
   section and subsections !!!

create list of mappings
   section ??
   subsections ??  to short (all lower case name) ??


use fields.csv   or mappings.csv ??

Num,Category,Name,Key

see http://wifo5-04.informatik.uni-mannheim.de/factbook/page/venezuela
```

