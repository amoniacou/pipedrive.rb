source 'https://rubygems.org'

# Specify your gem's dependencies in pipedrive.gemspec
gemspec

# TODO: remove after release of new faraday middleware
gem 'faraday_middleware', git: 'https://github.com/lostisland/faraday_middleware.git', branch: 'e169ab28a3f1fc6cc3160f86873903c7e5e8b882'

group :test do
  gem 'simplecov', :require => false
  gem 'coveralls', :require => false
end

group :local_development do
  gem 'terminal-notifier-guard', require: false if RUBY_PLATFORM.downcase.include?('darwin')
  gem 'guard-rspec', '>= 4.3.1' ,require: false
  gem 'guard-bundler', require: false
  gem 'guard-rubocop', require: false
  gem 'pry'
end
