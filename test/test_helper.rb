ENV['RACK_ENV'] = 'test'

require File.expand_path(File.join(File.dirname(__FILE__), "..", "init"))

require "test/unit"
require "rack/test"

class Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Main.new
  end
end
