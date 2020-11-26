# Notes


## Country Code Changes!!!

in 2018 / 2019 (?) Curacao changed the country code from `cc` to `uc`
and Sint Maarten from `sk` to `nn`
note: the old webpages are still available in the old format
with "PAGE LAST UPDATED ON MARCH 14, 2018",
see <https://www.cia.gov/library/publications/the-world-factbook/geos/cc.html>.
and "PAGE LAST UPDATED ON MARCH 15, 2018",
see <https://www.cia.gov/library/publications/the-world-factbook/geos/sk.html>



## Wikipedia

- [The_World_Factbook](https://en.wikipedia.org/wiki/The_World_Factbook)
- [List_of_entities_and_changes_in_The_World_Factbook](https://en.wikipedia.org/wiki/List_of_entities_and_changes_in_The_World_Factbook)   - changes over time


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



## How-To Update Code for New Page Structure / Site Changes

Steps to update to new page structure.

What links to use? (Example - Austria (`au`))

- <https://www.cia.gov/library/publications/the-world-factbook/geos/au.html>
- Print version? <https://www.cia.gov/library/publications/the-world-factbook/geos/print_au.html> (check: is the print version up-to-date)


### Step 1 - Try Sanitizer

- [ ] add new pages to /test/data/src
- [ ] update /test/test_sanitizer.rb  (to try new pages)
