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

