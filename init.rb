require File.join(File.dirname(__FILE__), 'lib/engines_helper/rails_extensions/asset_helpers')
EnginesHelper::Assets.propagate if EnginesHelper.autoload_assets
