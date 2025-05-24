# frozen_string_literal: true

require "bundler/gem_tasks"
require "minitest/test_task"

Minitest::TestTask.create

require "rubocop/rake_task"

RuboCop::RakeTask.new

require "rb_sys/extensiontask"

desc "Compile the extension"
task build: :compile

GEMSPEC = Gem::Specification.load("stemmers.gemspec")

RbSys::ExtensionTask.new("stemmers", GEMSPEC) do |ext|
  ext.lib_dir = "lib/stemmers"
end

task default: %i[compile test rubocop]
