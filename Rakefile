require 'hoe'
require './lib/factbook/version.rb'

Hoe.spec 'factbook' do

  self.version = Factbook::VERSION

  self.summary = 'factbook - scripts for the world factbook (get open structured data e.g JSON etc.)'
  self.description = summary

  self.urls = { home: 'https://github.com/factbook/factbook' }

  self.author = 'Gerald Bauer'
  self.email  = 'openmundi@googlegroups.com'

  # switch extension to .markdown for gihub formatting
  self.readme_file  = 'README.md'
  self.history_file = 'CHANGELOG.md'

  self.extra_deps = [
    ['logutils' ],
    ['csvreader'],
    ['webget'],
    ['nokogiri'],
    ['activerecord']  # note: will include activesupport,etc.
  ]

  self.licenses = ['Public Domain']

  self.spec_extras = {
   required_ruby_version: '>= 2.2.2'
  }

end
