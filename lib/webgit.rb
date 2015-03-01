require "webgit/version"
require "webgit/helpers"
require "webgit/app"

module Webgit
	GIT_REPO = ARGV[0] || Dir.pwd
  raise "#{GIT_REPO} is not a git repostory." unless File.exists? "#{GIT_REPO}/.git"
end
