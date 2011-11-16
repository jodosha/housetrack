#!/usr/bin/env rake
require 'bundler'
require 'bundler/gem_tasks'
Bundler.setup
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs.push 'lib'
  t.test_files = FileList['test/**/*_test.rb']
  t.ruby_opts  = ["-I test"]
  t.verbose    = true
end

task :default => :test
