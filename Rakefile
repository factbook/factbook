require 'hoe'
require './lib/factbook/version.rb'

Hoe.spec 'factbook' do

  self.version = Factbook::VERSION

  self.summary = 'factbook - scripts for the world factbook (get open structured data e.g JSON etc.)'
  self.description = summary

  self.urls = ['https://github.com/worlddb/factbook.ruby']

  self.author = 'Gerald Bauer'
  self.email = 'openmundi@googlegroups.com'

  # switch extension to .markdown for gihub formatting
  self.readme_file = 'README.md'
  self.history_file = 'HISTORY.md'

  self.extra_deps = [
    ['logutils' ],
    ['fetcher']
  ]

  self.licenses = ['Public Domain']

  self.spec_extras = {
   :required_ruby_version => '>= 1.9.2'
  }

end
