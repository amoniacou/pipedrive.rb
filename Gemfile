source 'https://rubygems.org'

# Specify your gem's dependencies in pipedrive.gemspec
gemspec

group :test do
  gem 'simplecov', '>= 0.9.0', :require => false
  gem 'coveralls', :require => false
end

group :local_development do
  gem 'terminal-notifier-guard', require: false if RUBY_PLATFORM.downcase.include?('darwin')
  gem 'guard-rspec', '>= 4.3.1' ,require: false
  gem 'guard-bundler', require: false
  gem 'guard-rubocop', require: false
  gem 'pry'
end
