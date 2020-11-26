# Todos


- [ ]  use Factbook terminology  - why? why not?
       - change subsection to field!!
       - change categories.csv to fields.csv (keep name as it is field name now not wrongly category name)
       - change structs too!! - use Section => Category, Subsection => Field




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

