
module Factbook
  module NormalizeHelper


def normalize_category( text )

  ## note: fix typos/errors with double colons e.g. note::  (instead of note:)

  text = text.strip
  text = text.sub( /:+\z/, '' )      # remove trailing : if present -- note: allow (fix) note:: too, thus, use :+
  text = text.strip

  #######################################
  ### special cases

  ##   typos e.g ntoe => use note
  text = 'note'                         if text == 'ntoe'
  text = 'investment in fixed capital'  if text == 'investment if fixed capital'

  ##  downcase
  text = 'lowest point'    if text == 'Lowest point'
  text = 'chief of state'  if text == 'Chief of state'

  ##  spelling variant (use more popular one)
  text = 'signed, but not ratified'     if text == 'signed but not ratified'
  text = 'vectorborne diseases'         if text == 'vectorborne disease'
  text = 'water contact disease'        if text == 'water contact diseases'
  text = 'food or waterborne diseases'  if text == 'food or waterborne disease'
  text = 'geographic coordinates'       if text == 'geographical coordinates'
  text = 'note'                         if text == 'notes'
  text = 'refugees (country of origin)' if text == 'refugees (countries of origin)'

  ##    border countries (8):   -- remove (x) counter
  text = 'border countries'   if text.start_with?( 'border countries')

  text
end


  end # module NormalizeHelper
end  # module Factbook
