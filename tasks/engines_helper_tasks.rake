namespace :engines do
  namespace :sync do
    desc "Sync all plugin migrations to the parent application"
    task :migrations do
    
      puts ""
      puts "Syncing migrations ..."
      puts ""
      Dir.glob(File.dirname(__FILE__) + '/../../*').each do |plugin|
        system "mkdir -p db/migrate"
        Dir.glob(plugin + '/db/migrate/[0-9]*_*.rb') do |migration|
          puts "Syncing #{File.basename(plugin)} migration #{File.basename(migration)}"
          system "rsync -u #{migration} db/migrate"
        end
      end
      puts ""
      puts "Sync complete. (You will still need to run the migrations.)"
      puts ""
  
    end
  end
end