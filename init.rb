ROOT_DIR = File.expand_path(File.dirname(__FILE__)) unless defined? ROOT_DIR

require "rubygems"

begin
  require File.expand_path("vendor/dependencies/lib/dependencies", File.dirname(__FILE__))
rescue LoadError
  require "dependencies"
end

require "monk/glue"
require "haml"
require "sass"
require "data_mapper"
require "spawn"
require "faker"

class Main < Monk::Glue
  set :app_file, __FILE__
  use Rack::Session::Cookie
end

db = monk_settings(:postgresql)

DataMapper.setup(:default, "postgres://#{db[:username]}:#{db[:password]}@#{db[:host]}:#{db[:port]}/#{db[:database]}")

# Load all application files.
Dir[root_path("app/**/*.rb")].each do |file|
  require file
end

DataMapper.finalize

if defined? Encoding
  Encoding.default_external = Encoding::UTF_8
end

Main.run! if Main.run?
