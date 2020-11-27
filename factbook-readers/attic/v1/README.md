# Attic v1  (Anno 2018?)


## Encoding Errors / Charset?


some factbook pages with chrome (headers, footers, etc.)
- are NOT valid utf-8, thus,
- treat page as is (e.g. ASCII8BIT)

only convert to utf8 when header and footer got stripped

example: be/benin:


-  Key Force or FC [Lazare S?xx?HOU?xx?TO]     -- two invalid byte code chars in Political parties and leaders:

- in Western/Windows-1252  leads to  FC [Lazare SÈHOUÉTO];   Lazare Sèhouéto

looks good - use (assume) Windows-1252 ????

check for is ascii 7-bit ??? - if yes -no worries;
if not, log number of chars not using ascii 7-bit


```

```
