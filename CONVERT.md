# Convertsion Notes


With the 2021 factbook website relaunch - the CIA
now offers one JSON dataset / page per country profile!

This pages keeps notes on how to convert the "verbose"
raw format into the "classic" compact format.



## How to handle categories

All categories (e.g. Introduction, Geography, People and Society, Environment, Government, Economy, etc)
are accessible via  `data['categories']`.



## How to handle fields

All fields
are accessible via `data['fields]`.

All fields have an numeric id and a name  - plus a redundant(?) title.

The content property holds the content / text - sometimes with some
extra html tags (e.g. wrapped in a paragraph) - clean up- why? why not?

If the field has subfields then the content property is a folded summary
of all subfields content properties (usually
the subfield name gets added wrapped in strong tags)
and the subfields separated / divided by double break tags.

How to handle notes? If present break out of content / text - why? why not?



## How to handle subfields

All subfields
are accessible via `data['subfields]`.



## How to handle comparable (tagged/marked) fields




## Stats

categories (12):

```
{"Introduction"=>260,
 "Geography"=>260,
 "People and Society"=>256,
 "Environment"=>260,
 "Government"=>260,
 "Economy"=>260,
 "Energy"=>235,
 "Communications"=>249,
 "Transportation"=>260,
 "Military and Security"=>258,
 "Terrorism"=>78,
 "Transnational Issues"=>255}
```

properties:

```
categories
  {"id"=>2891,
   "title"=>2891,
   "fields"=>2891},

fields
  {"name"=>38661,
   "field_id"=>38661,
   "comparative"=>38328,
   "content"=>38661,
   "subfields"=>16214,
   "media"=>1044,
   "value"=>10233,
   "suffix"=>9505,
   "subfield_note"=>762,
   "estimated"=>10162,
   "info_date"=>12823,
   "field_note"=>2472,
   "prefix"=>231},

 subfields
  {"name"=>49098,
   "content"=>49098,
   "title"=>37468,
   "value"=>48820,
   "suffix"=>23734,
   "estimated"=>23556,
   "info_date"=>17559,
   "subfield_note"=>3476,
   "prefix"=>3614}
```