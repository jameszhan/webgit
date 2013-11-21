version = File.read(File.expand_path("../../MULBERRY_VERSION", __FILE__)).strip

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "webgit"
  s.version     = version
  s.authors     = ["James Zhan"]
  s.email       = ["zhiqiangzhan@gmail.com"]
  s.homepage    = "https://github.com/jameszhan"
  s.summary     = "Git Web Client"
  s.description = "Git Web Client."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'rugged'
  s.add_dependency 'coderay'
end