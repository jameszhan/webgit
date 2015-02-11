# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webgit/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "webgit"
  s.version     = Webgit::VERSION
  s.authors     = ["James Zhan"]
  s.email       = ["zhiqiangzhan@gmail.com"]
  s.homepage    = "https://github.com/jameszhan"
  s.summary     = "Git Web Client"
  s.description = "Git Web Client."
  s.homepage    = "http://www.github.com/jameszhan/webgit"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'rugged', '>= 0.21'
  s.add_dependency 'coderay', '>= 1.1'
end