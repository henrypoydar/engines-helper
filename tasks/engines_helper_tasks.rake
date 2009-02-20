namespace :engines do
  namespace :sync do
    
    desc "Sync all plugin migrations to the parent application"
    task :migrations do
    
      puts ""
      puts "Syncing migrations ..."
      puts ""
      system "mkdir -p db/migrate"
      Dir.glob(File.dirname(__FILE__) + '/../../*').each do |plugin|
        Dir.glob(plugin + '/db/migrate/[0-9]*_*.rb') do |migration|
          puts "Syncing #{File.basename(plugin)} migration #{File.basename(migration)}"
          system "rsync -u #{migration} db/migrate"
        end
      end
      puts ""
      puts "Sync complete. (You will still need to run the migrations.)"
      puts ""
  
    end
    
    desc "Sync all plugin migrations to the parent application"
    task :assets => :environment do
    
      if EnginesHelper.autoload_assets 
        puts ""
        puts "Syncing of plugin assets will happen automatically when the application loads."
        puts "To disable this behavior and sync the plugin public folders with the"
        puts "parent application on demand with this rake task, set"
        puts "EnginesHelper.autoload_assets = false in environment.rb."
        puts ""
        exit
      end
    
      puts ""
      puts "Syncing assets ..."
      puts ""
      system "mkdir -p public"
      Dir.glob(File.dirname(__FILE__) + '/../../*').each do |plugin|
        if File.exist?("#{plugin}/public")
          puts "Syncing #{File.basename(plugin)} public folder"
          system "rsync -ru #{plugin}/public ."
        end
      end
      puts ""
      puts "Sync complete."
      puts ""
  
    end
    
  end
end