require File.dirname(__FILE__) + '/spec_helper'

describe 'EnginesHelper' do
  
  # Setup a mock engines plugin
  before :all do
    @rails_root = File.dirname(__FILE__) + '/../../../..'
    FileUtils.cp_r(
      File.dirname(__FILE__) + '/mock-plugin', 
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
    
    
  end
  
end