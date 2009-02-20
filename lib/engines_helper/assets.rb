module EnginesHelper::Assets
  extend self

  # Propagate the public folders
  def propagate
    return if !EnginesHelper.autoload_assets
    plugin_list.each do |plugin|
      FileUtils.mkdir_p "#{RAILS_ROOT}/public/#{EnginesHelper.plugin_assets_directory}/#{plugin}"
      Dir.glob("#{RAILS_ROOT}/vendor/plugins/#{plugin}/public/*").each do |asset_path|
        FileUtils.cp_r(asset_path, "#{RAILS_ROOT}/public/#{EnginesHelper.plugin_assets_directory}/#{plugin}/.")
      end
    end
  end

private

  def plugin_list
    Dir.glob("#{RAILS_ROOT}/vendor/plugins/*").reject { |p| 
      !File.exist?("#{RAILS_ROOT}/vendor/plugins/#{File.basename(p)}/public") 
    }.map { |d| File.basename(d) }
  end

end