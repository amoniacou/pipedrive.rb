require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

# rubocop
require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop)

# reek
require 'reek/rake/task'

Reek::Rake::Task.new do |t|
  t.fail_on_error = false
  t.source_files = Dir['lib/**/*.rb']
end

default_tasks = [:spec, :rubocop, :reek]

unless defined? ::Rubinius
  # cane
  require 'cane/rake_task'
  Cane::RakeTask.new
  default_tasks << :cane
end

task default: default_tasks
