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
  
  # Call this from environment.rb to port over sass directories too
  # Must be called from environment.rb because it needs to run after all
  # the plugins are initialized
  def update_sass_directories
    
    if check_for_haml
      
      unless Sass::Plugin.options[:template_location].is_a?(Hash)
        Sass::Plugin.options[:template_location] = {
        Sass::Plugin.options[:template_location] => Sass::Plugin.options[:template_location].gsub(/\/sass$/, '') }
      end
      
      Dir.glob("#{RAILS_ROOT}/public/#{EnginesHelper.plugin_assets_directory}/**/sass") do |sass_dir|
        Sass::Plugin.options[:template_location] =
          Sass::Plugin.options[:template_location].merge({
          sass_dir => sass_dir.gsub(/\/sass$/, '')
        })
      end
    
    end
  end
  
private
  
  def plugin_list
    Dir.glob("#{RAILS_ROOT}/vendor/plugins/*").reject { |p| 
      !File.exist?("#{RAILS_ROOT}/vendor/plugins/#{File.basename(p)}/public") 
    }.map { |d| File.basename(d) }
  end
  
  def check_for_haml
    $LOAD_PATH.reject { |p| !(p =~ /\/haml/) }.size > 0 ? 
      @haml_present = true : @haml_present = false 
  end

end