require 'bundler/gem_tasks'
require 'rake/testtask'

task :default => :test

Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.test_files = FileList['spec/*_test.rb']
  t.warning = true
end