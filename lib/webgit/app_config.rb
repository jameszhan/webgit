module Webgit
  class AppConfig
    REPOS = YAML.load_file(Rails.root + "config/repos.yml")
  end
end
