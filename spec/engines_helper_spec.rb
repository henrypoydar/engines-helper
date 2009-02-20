require File.dirname(__FILE__) + '/spec_helper'

describe 'EnginesHelper' do
  
  # Setup a mock engines plugin
  before :all do
    @rails_root = File.dirname(__FILE__) + '/../../../..'
    FileUtils.cp_r(
      File.dirname(__FILE__) + '/mock_plugin', 
      "#{@rails_root}/vendor/plugins/engine-helpers-mock")
  end
  
  # Teardown
  after :all do
    FileUtils.rm_rf "#{@rails_root}/vendor/plugins/engine-helpers-mock"
  end
  
  
  describe 'migrations' do
    
    before :each do
      @migrations = Dir.glob(
        "#{@rails_root}/vendor/plugins/engine-helpers-mock/db/migrate/[0-9]*_*.rb").map { |migration|
        File.basename(migration)
      }
    end

    it "should sync up the migrations when the rake task is run" do
      system "cd #{@rails_root} && rake engines:sync:migrations"
      @migrations.each do |migration|
        File.exist?("#{@rails_root}/db/migrate/#{migration}").should be_true
      end
      @migrations.each do |migration|
        FileUtils.rm_rf "#{@rails_root}/db/migrate/#{migration}"
      end
    end
    
  end
  
  describe 'asset management' do
    

    describe 'with autoload_assets true' do
      
      before :each do
        EnginesHelper.autoload_assets = true
      end
      
      it "should autoload assets" do
       
      
      end
    
    end
    
    describe 'with autoload_assets false' do
      
      before :all do
        FileUtils.cp(
          File.dirname(__FILE__) + '/mock_initializers/autoload_assets_false.rb', 
          "#{@rails_root}/config/initializers/engines_helper_spec_run.rb")
        @assets = %w(images/engine_helper_mock.png javascripts/engine_helper_mock.js stylesheets/engine_helper_mock.css)
      end
      
      after :all do
        FileUtils.rm_rf "#{@rails_root}/config/initializers/engines_helper_spec_run.rb"
        @assets.each do |asset|
          FileUtils.rm_rf "#{@rails_root}/public/#{asset}"
        end
      end
      
      it "should sync up the assets when the rake task is run" do
        system "cd #{@rails_root} && rake engines:sync:assets"
        @assets.each do |asset|
          File.exist?("#{@rails_root}/public/#{asset}").should be_true
        end
      end
      
    end
    
  end
  
end