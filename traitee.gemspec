# -*- encoding: utf-8 -*-
require File.expand_path('../lib/traitee/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'traitee'
  s.version     = Traitee::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Adam Lieskovsky']
  s.email       = ['adamliesko@gmail.com']
  s.homepage    = 'http://github.com/adamliesko/traitee'
  s.summary     = 'Mixins or so called traits for Ruby'
  s.description = 'Traits for Ruby - more dynamic implementation of classic include/extend feature.'
  s.license     = 'MIT'

  s.add_development_dependency 'minitest'

  s.files        = Dir['lib/**/*.rb'] + ['README.md', 'LICENSE.txt']
  s.require_path = 'lib'
end
