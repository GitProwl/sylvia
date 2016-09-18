# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "sylvia/version"

Gem::Specification.new do |s|
  s.name        = "sylvia"
  s.version     = Sylvia::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Montana Mendy"]
  s.email       = ["montana@montanamendy.com"]
  s.homepage    = "http://github.com/montana"
  s.summary     = %q{Updated version of Refuse, to defer garbage in Ruby}

  s.rubyforge_project = "sylvia"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
