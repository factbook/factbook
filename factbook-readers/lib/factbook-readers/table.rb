# encoding: utf-8

module Factbook

##
## make more "generic"  - why? why not?
##   (re)use for other files ?? move to textutils ??

##
##  for now reads in rows with values separated by at least 3+ spaces e.g.:
##   see www.cia.gov/library/publications/the-world-factbook/rankorder/rawdata_2119.txt
## 1      China                      1,367,485,388                                     
## 2      India                      1,251,695,584                                     
## 3      European Union             513,949,445                                       
## 4      United States              321,368,864                                       
## 5      Indonesia                  255,993,674                                       
## 6      Brazil                     204,259,812     


class TableReader
  include LogUtils::Logging


def initialize( text )
  @text = text
end

def read
  recs = []

  line_no = 0
  @text.each_line do |line|
    line_no +=1
    line = line.strip   ## remove leading and trailing whitespace
    if line.empty?
      puts "** skipping empty line #{line_no}"
      next
    end

    values = line.split( /[ ]{3,}/ )    ## split three or more spaces - use just two ?? why? why not??
    
    ## puts line
    ## pp values
    recs << values
  end
  recs
end


end # class TableReader

end # module Factbook
