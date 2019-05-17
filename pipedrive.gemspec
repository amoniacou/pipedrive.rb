# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pipedrive/version'

Gem::Specification.new do |gem|
  gem.name          = "pipedrive.rb"
  gem.version       = Pipedrive::VERSION
  gem.authors       = ["Alexander Simonov"]
  gem.email         = ["alex@simonov.me"]
  gem.summary       = %q{Pipedrive.com API Wrapper}
  gem.description   = %q{Pipedrive.com API Wrapper}
  gem.homepage      = 'https://github.com/dotpromo/pipedrive.rb'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z`.split("\x0")
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_dependency('activesupport', '>= 4.0.0')
  gem.add_dependency('faraday')
  gem.add_dependency('faraday_middleware')
  gem.add_dependency('hashie', '>= 3.0')
  gem.add_development_dependency('bundler')
  gem.add_development_dependency('rake', '< 12')
  gem.add_development_dependency('rspec', '>= 3.0')
  gem.add_development_dependency('rubocop')
  gem.add_development_dependency('webmock')
end
