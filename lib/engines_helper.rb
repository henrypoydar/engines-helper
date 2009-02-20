

module EnginesHelper

  # Configuration and defaults
  mattr_accessor :autoload_assets
  mattr_accessor :plugin_assets_directory
  
  self.autoload_assets = true
  self.plugin_assets_directory = 'plugin_assets'
 
end
