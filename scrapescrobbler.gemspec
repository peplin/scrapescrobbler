# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'scrapescrobbler/version'

Gem::Specification.new do |s|
  s.name = "scrapescrobbler"
  s.version = Scrapescrobbler::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Christopher Peplin"]
  s.email = %q{chris.peplin@rhubarbtech.com}
  s.homepage = "http://github.com/peplin/scrapescrobbler"
  s.summary = %q{Radio station last.fm scrobbler}
  s.description = %q{Scrapescobbler is a tool to submit tracks you're listening to on an old-fashioned radio station to last.fm.}

  s.required_rubygems_version = ">= 1.3.6"

  s.add_development_dependency "rspec"
  s.add_development_dependency "mocha"
  s.add_dependency "hpricot"
  s.add_dependency "lastfm", ">= 0.2.0"
  s.add_dependency "dm-core"
  s.add_dependency "dm-sqlite-adapter"
  s.add_dependency "dm-migrations"
  s.add_dependency "dm-validations"
  s.add_dependency "activesupport", ">= 3.0.0"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec/*`.split("\n")
  s.executables = `git ls-files bin/*`.split("\n").map{ |f| File.basename(f) }
  s.default_executable = "scrapescrobble"
  s.require_paths = ["lib"]
end
