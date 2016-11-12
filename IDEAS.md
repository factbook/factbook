
# Ideas, Suggestions

###  field ids

Each field has its own ID. ID gets included in the JSON output. Benefits: 

- the Factbook contains descriptions for all fields which could be referenced/downloaded/extracted using this ID. 

- The field description could also be used to create a mapping "field_names_used_in_JSON" 
  to their respective original text (or: as an alternative, the original field name 
  could be included in the output itself)

- the Factbook contains text tables containing the raw data for numeric fields, 
  so there is no need to sanitize the fields to get their numeric values.  
  To reference these raw data tables the field ID is needed
  the Factbook contains field listings (the compiled values of fields for all countries). 
  To reference these tables the field ID is needed, again


### pseudo header section

Include a pseudo section in the JSON output
to make the entries more descriptive / self-contained (to be located at the top, before intro):

~~~
"header" : {
   "country" : "Austria",
   "fips" : "at"
}
~~~

The header, if included, should contain

- name of the territory in question, e.g. Virgin Islands
- name of parent region, e.g. Central America and Caribbean
- dependency, e.g (territory of the US)
- date of last update, e.g Page last updated on June 20, 2014
- fips code, e.g., VQ
- date & time when the json file was produced


### Statistics

One of the issues when using the data for statistics is not having a way to track time.

 - The factbook has had varying update schedules: Yearly, monthly, weekly. 
   A **year by year** breakdown is possible, as we have year by year back ups available dating back about 15 years. The problem is parsing the changes from each backup could be tedious.

 - Although we can have a version year to year, not each section of information is updated each year. Using the **"YEAR est."** fields can help us breakdown the down dates more.

 - Eventually compile printed books for source material?



### "Normalize" fields

A couple of countries in the dataset don't conform to a standard way to programmatically access their names. 
I think it's just Curacao (`cc`) and Sint Maarten (`sk`).

Their names are both stored under `["Government"]["Country name"]["Dutch short form"]`.
Every other country uses `["Government"]["Country name"]["conventional short form"]`.

I gather this is just a harvested dataset rather than a curated one, but how do you feel about this? 
If people want to use this data programatically, it's inconvenient that something as major as the name of a country can't be reliably retrieved. (Other more complex properties, I can understand).

PS: European Union (`ee`) is another file which uses a different convention.


### Thanks
