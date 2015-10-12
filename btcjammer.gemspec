# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'btcjammer/version'

Gem::Specification.new do |spec|
  spec.name          = 'btcjammer'
  spec.version       = BTCJammer::VERSION
  spec.authors       = ['Chris Cacciatore']
  spec.email         = ['chris.cacciatore@dullahansoft.com']
  spec.summary       = 'A gem to wrap the BTCJam API.'
  spec.description   = 'A simple wrapper for BTCJam API calls with support for user authenticated API calls.'
  spec.homepage      = 'https://github.com/cacciatc/btcjammer'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.8'
  spec.add_development_dependency 'vcr',	'~> 2.9'
  spec.add_development_dependency 'webmock', '~> 1.21'
  spec.add_development_dependency 'rubocop', '~> 0.34'

  spec.add_dependency 'faraday', '~> 0.9'
  spec.add_dependency 'json', '~> 1.8'
  spec.add_dependency 'oauth2', '~> 1.0'
end
