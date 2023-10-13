# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name        = 'activerecord-not_nil'
  spec.version     = '0.0.0'
  spec.summary     = 'Add support for a not_nill type to active record.'
  spec.files       = ['lib/activerecord-not_nil.rb']
  spec.authors     = ['Payt devs']
  spec.email       = ['devs@paytsoftware.com']

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency 'activerecord'
  spec.add_dependency 'not_niller'
end
