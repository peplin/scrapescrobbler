# -*- encoding: utf-8 -*-
$:.unshift File.expand_path("../lib", __FILE__)

require 'rubygems'
require 'rubygems/specification'
require 'rake/gempackagetask'
require 'scrapescrobbler'

def gemspec
  @gemspec ||= begin
    file = File.expand_path('../scrapescrobbler.gemspec', __FILE__)
    eval(File.read(file), binding, file)
  end
end

begin
  require 'rspec/core/rake_task'

  task :default => :spec

  desc "Run specs"
  RSpec::Core::RakeTask.new do |t|
    t.rspec_opts = %w(-fs --color)
  end

  namespace :spec do
    task :clean do
      if sudo?
        system "sudo rm -rf #{File.expand_path('../tmp', __FILE__)}"
      else
        rm_rf 'tmp'
      end
    end

    desc "Run the full spec suite"
    task :full => ["clean", "spec"]
  end
rescue LoadError
  task :spec do
    abort "Run `gem install rspec` to be able to run specs"
  end
end

Rake::GemPackageTask.new(gemspec) do |pkg|
  pkg.gem_spec = gemspec
end

desc "install the gem locally"
task :install => [:package] do
  sh %{gem install pkg/#{gemspec.name}-#{gemspec.version}}
end

desc "validate the gemspec"
task :gemspec do
  gemspec.validate
end
