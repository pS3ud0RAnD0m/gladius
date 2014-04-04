require_relative '../../../lib/menus/splash'

require_relative '../../../lib/helpers/path'
include Path
Path.load
Path.req


describe "Splash" do
  before do
    STDOUT.stub(:puts)
  end
  #describe "#splash" do 

  it "displays splash" do
    STDOUT.should_receive(:puts).with("/\\")
    Splash.new.iterate
  end
end

