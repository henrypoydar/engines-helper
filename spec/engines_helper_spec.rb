require File.dirname(__FILE__) + '/spec_helper'

describe 'EnginesHelper' do
  
  # Setup
  before :all do
    #puts File.dirname(__FILE__) + '/mock-plugin'
    FileUtils.cp_r(
      File.dirname(__FILE__) + '/mock-plugin', 
      File.dirname(__FILE__) + '/../../../../vendor/plugins/engine-helpers-mock',
      :verbose => true)
  end
  
  # Teardown
  after :all do
    
  end
  
  
  describe 'migrations' do
    
    it "should balh"
    
  end
  
  describe 'asset management' do
    
    
  end
  
end