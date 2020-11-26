# encoding: utf-8

module Factbook

class Importer

def import( page )

  ## note: assumes active connection

  code  = page.info.country_code
  name  = page.info.country_name

  attribs = {
   name:       name,
   area:       sq_km( page.area ),        # e.g. 83,871 sq km       
   area_land:  sq_km( page.area_land ),   # e.g. 82,445 sq km
   area_water: sq_km( page.area_water ),  # e.g.  1,426 sq km

   population:         num( page.population ),                   # e.g.  8,665,550 (July 2015 est.)  
   population_growth:  percent( page.population_growth ),        # e.g.  0.55% (2015 est.)
   birth_rate:         rate_per_thousand( page.birth_rate ),     # e.g.  9.41 births/1,000 population (2015 est.)
   death_rate:         rate_per_thousand( page.death_rate ),     # e.g.  9.42 deaths/1,000 population (2015 est.)
   migration_rate:     rate_per_thousand( page.migration_rate ), # e.g.  5.56 migrant(s)/1,000 population (2015 est.)
  }

  rec = Fact.find_by( code: code )
  if rec.nil?   ## create (new) record
    rec = Fact.new
    attribs[ :code ] = code
    puts "create fact record #{code}/#{name}:"
  else          ## update (exisiting) record
    puts "update fact record #{code}/#{name}:"
  end
  
  puts "  #{attribs.inspect}"
  rec.update_attributes!( attribs )
end


def rate_per_thousand( text )
  # e.g.  9.41 births/1,000 population (2015 est.)
  #       9.42 deaths/1,000 population (2015 est.)
  #       5.56 migrant(s)/1,000 population (2015 est.)

  if text =~/([0-9\.]+) [a-z\(\)]+\/1,000/
    $1.to_f
  else
    puts "*** warn: unknown rate <name>/1,000 format (no match): >#{text}<"    
    nil
  end
end

def num( text )
  # e.g. 8,665,550 (July 2015 est.) 

  if text =~/([0-9,\.]+)/
    $1.gsub(',', '').to_i   ## note: remove commas (,) if present
  else
    puts "*** warn: unknown number format (no match): >#{text}<"
    nil   ## return nil
  end
end

def percent( text )
  # e.g. 0.55% (2015 est.)

  if text =~/([0-9\.]+)%/
    $1.to_f
  else
    puts "*** warn: unknown percent format (no match): >#{text}<"
    nil   ## return nil
  end
end

def sq_km( text )
  # e.g. 83,871 sq km
  ##   todo - check vatican - uses float e.g. 0.44 ?? add support?
  
  if text =~/([0-9,\.]+) sq km/
    $1.gsub(',', '').to_i   ## note: remove commas (,) if present
  else
    puts "*** warn: unknown sq km format (no match): >#{text}<"
    nil   ## return nil
  end
end


end # class Importer

end # module Factbook

