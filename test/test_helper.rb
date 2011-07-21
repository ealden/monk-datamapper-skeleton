ENV['RACK_ENV'] = 'test'

require File.expand_path(File.join(File.dirname(__FILE__), "..", "init"))

require "test/unit"
require "rack/test"

class Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Main.new
  end

  def load_data(*paths)
    data_dir = File.join(File.dirname(__FILE__), "..", "data", "datamapper")

    load_common_data(data_dir)

    load File.expand_path(File.join(data_dir, ENV['RACK_ENV'], paths))
  end

private

  def load_common_data(data_dir)
    common_data_path = File.expand_path(File.join(data_dir, "common", "*.rb"))

    Dir[common_data_path].each do |file|
      load file unless file =~ /^-/
    end
  end
end
