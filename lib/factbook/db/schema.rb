# encoding: utf-8

module Factbook

class CreateDb

def up

ActiveRecord::Schema.define do

create_table :facts do |t|
  t.string  :code,   null: false   # country code e.g. au
  t.string  :name,   null: false   # country name e.g. Austria

  t.integer :area        # e.g. 83,871 sq km       
  t.integer :area_land   # e.g. 82,445 sq km    --use float - why? why not?
  t.integer :area_water  # e.g.  1,426 sq km

  t.integer :population            # e.g.  8,665,550 (July 2015 est.)  
  t.float   :population_growth     # e.g.  0.55% (2015 est.)
  t.float   :birth_rate            # e.g.  9.41 births/1,000 population (2015 est.)
  t.float   :death_rate            # e.g.  9.42 deaths/1,000 population (2015 est.)
  t.float   :migration_rate        # e.g.  5.56 migrant(s)/1,000 population (2015 est.)

  t.timestamps
end


end # block Schema.define

end # method up


end # class CreateDb

end # module Factbook
