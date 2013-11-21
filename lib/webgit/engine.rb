module Webgit
  class Engine < ::Rails::Engine
    isolate_namespace Webgit
    
    config.before_configuration do
      require 'webgit/app_config'
    end
    
  end
end
