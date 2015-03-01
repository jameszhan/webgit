# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'webgit/version'

Gem::Specification.new do |spec|
  spec.name          = "webgit"
  spec.version       = Webgit::VERSION
  spec.authors       = ["James Zhan"]
  spec.email         = ["zhiqiangzhan@gmail.com"]
  spec.homepage      = "http://www.github.com/jameszhan/webgit"
  
  spec.summary       = "Git Web Client"
  spec.description   = "Git Web Client."
  spec.homepage      = "http://www.github.com/jameszhan/webgit"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }

  spec.bindir        = "bin"  
  spec.executables   = spec.files.grep(%r{^bin/webgit}) { |f| File.basename(f) }

  spec.require_paths = ["lib"]  

  spec.add_dependency "sinatra",  '~> 1.4'
  spec.add_dependency 'rugged',   '~> 0.21'
  spec.add_dependency 'coderay',  '~> 1.1'
  spec.add_dependency "mime-types", '~> 2.4'

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
end
