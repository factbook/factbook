# Notes

## Country (Processing/Parsing/Reading Notes)

### France

Metropolitan France is the name for the "continental" France without overseas departments.
The five overseas departments include:

- French Guiana -- in South America
- Guadeloupe -- in the Caribbean (Americas)
- Martinique -- in the Caribbean (Americas)
- Mayotte -- in the Indian Ocean (Africa)
- Réunion -- in the Indian Ocean (Africa)

### Cyprus

Some entries divived by:

- area under government control
- area administered by Turkish Cypriots



## History / What's News?

See <https://www.cia.gov/library/publications/the-world-factbook/docs/whatsnew.html>
and <https://www.cia.gov/library/publications/the-world-factbook/docs/history.html>



## Country Comparison Pages

Country Comparison pages are presorted lists of data from selected Factbook data fields.
Country Comparison pages are generally given in descending order - highest to lowest - such as Population and Area.
The two exceptions are Unemployment Rate and Inflation Rate, which are in ascending - lowest to highest - order.

Country Comparison pages are available for the following 79 fields in seven of the ten Factbook categories.

(Source: [Guide to Country Comparisons](https://www.cia.gov/library/publications/the-world-factbook/rankorder/rankorderguide.html))



## Alternatives (Libraries and Gems)

Ruby

- [worldfactbook gem](https://github.com/sayem/worldfactbook)
  by Sayem Khan (aka sayem);
  fetches data from its own mirror, that is, [rubyworldfactbook.com](http://rubyworldfactbook.com)
  (last updated 2011?)

- [the_country_identity gem](https://github.com/p1nox/the_country_identity)
  by Raul Pino (aka p1nox);
  fetches data from an [RDF Turtle endpoint](http://wifo5-03.informatik.uni-mannheim.de/factbook/)
  hosted by the Research Group Data and Web Science at the University of Mannheim, Germany

JavaScript

- [worldfactbook-dataset](https://github.com/twigkit/worldfactbook-dataset)
  by Richard Marr (aka richmarr); fetches data using Node.js
  (last updated 2013)

Python

- [openfactbook datasets & tools](https://github.com/openfactbook)
  by Eckhard Licher; uses official (offline) download archive (last updated 2014); incl. flags, maps, and more

Others

TBD



## How-To Update Code for New Page Structure / Site Changes

Steps to update to new page structure.

What links to use? (Example - Austria (`au`))

- <https://www.cia.gov/library/publications/the-world-factbook/geos/au.html>
- Print version? <https://www.cia.gov/library/publications/the-world-factbook/geos/print_au.html> (check: is the print version up-to-date)


### Step 1 - Try Sanitizer

- [ ] add new pages to /test/data/src
- [ ] update /test/test_sanitizer.rb  (to try new pages)
