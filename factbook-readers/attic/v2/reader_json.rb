
module Factbook


class JsonPageReader
  def initialize( json_dir )
    @json_dir = json_dir
  end

def read_page( code )
  path = "#{@json_dir}/#{region_to_slug(code.region)}/#{code.code}.json"

  puts "reading #{code.code} #{code.name} (#{code.region}) [#{path}]..."
  json = File.read( path, 'r:utf-8' ) { |f| f.read }

## todo/fix/quick hack: for now until we have a proper header/meta/info section in json
#    add some page info from code struct

  info = PageInfo.new
  info.country_code = code.code
  info.country_name = code.name
  info.region_name  = code.region

  page = Page.new( code.code, json: json, info: info )
  page
end

def read_pages( codes, limit: nil )
  pages = []
  i=0
  codes.each do |code|
    next if limit && i > limit   ## for debugging just process first x entries

    pages << read_page( code )
  end
  pages
end

private
def region_to_slug( text )
  ##  change and  =>  n
  ##  change  &   =>  n
  ##  change all spaces to => -
  ##   e.g. East & Southeast Asia          => east-n-southeast-asia
  ##        Central America and Caribbean  => central-america-n-caribbean
  text.downcase.gsub('and', 'n').gsub( '&', 'n' ).gsub( ' ', '-' )
end
end ## JsonPageReader

end # module Factbook
