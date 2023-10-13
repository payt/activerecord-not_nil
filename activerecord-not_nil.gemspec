# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name     = 'activerecord-not_nil'
  spec.version  = '0.0.2'
  spec.summary  = 'Add support for a not_nill type to active record.'
  spec.files    = Dir['lib/**/*.rb']
  spec.authors  = ['Payt devs']
  spec.email    = ['devs@paytsoftware.com']
  spec.homepage = 'https://github.com/payt/activerecord-not_nil'
  spec.license  = 'MIT'

  spec.required_ruby_version = '>= 2'

  spec.add_dependency 'activerecord', '> 6', '< 8'
  spec.add_dependency 'not_niller', '0.0.0'
end
