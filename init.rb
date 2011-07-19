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

class Main < Monk::Glue
  set :app_file, __FILE__
  use Rack::Session::Cookie
end

host = monk_settings(:postgresql)[:host]
port = monk_settings(:postgresql)[:port]
username = monk_settings(:postgresql)[:username]
password = monk_settings(:postgresql)[:password]
database = monk_settings(:postgresql)[:database]

DataMapper.setup(:default, "postgres://#{username}:#{password}@#{host}:#{port}/#{database}")

# Load all application files.
Dir[root_path("app/**/*.rb")].each do |file|
  require file
end

DataMapper.finalize

if defined? Encoding
  Encoding.default_external = Encoding::UTF_8
end

Main.run! if Main.run?
