class Monk < Thor
  include Thor::Actions

  desc "migrate", "Migrate DataMapper"
  def migrate(env = ENV['RACK_ENV'] || "development")
    verify_config(env)

    load "init.rb"
    DataMapper.auto_migrate!

    say_status :success, "Database migration completed!"
  end

  desc "upgrade", "Upgrade DataMapper"
  def upgrade(env = ENV['RACK_ENV'] || "development")
    verify_config(env)

    load "init.rb"
    DataMapper.auto_upgrade!

    say_status :success, "Database upgrade completed!"
  end

  desc "populate", "Populate database"
  def populate(env = ENV['RACK_ENV'] || "development")
    verify_config(env)

    Dir["data/datamapper/#{env}/*.rb"].each do |file|
      load file unless file =~ /^-/
    end
  end

  desc "test", "Run all tests"
  def test
    verify_config(:test)

    $:.unshift File.join(File.dirname(__FILE__), "test")

    Dir['test/**/*_test.rb'].each do |file|
      load file unless file =~ /^-/
    end
  end

  desc "stories", "Run user stories."
  method_option :pdf, :type => :boolean
  def stories
    $:.unshift(Dir.pwd, "test")

    ARGV << "-r"
    ARGV << (options[:pdf] ? "stories-pdf" : "stories")
    ARGV.delete("--pdf")

    Dir["test/stories/*_test.rb"].each do |file|
      load file
    end
  end

  desc "start ENV", "Start Monk in the supplied environment"
  def start(env = ENV["RACK_ENV"] || "development")
    verify_config(env)
    say_status :success, "Starting Monk in #{env} environment"

    exec "env RACK_ENV=#{env} ruby init.rb"
  end

  desc "copy_example EXAMPLE, TARGET", "Copies an example file to its destination"
  def copy_example(example, target = target_file_for(example))
    File.exists?(target) ? return : say_status(:missing, target)
    File.exists?(example) ? copy_file(example, target) : say_status(:missing, example)
  end

private

  def self.source_root
    File.dirname(__FILE__)
  end

  def target_file_for(example_file)
    example_file.sub(".example", "")
  end

  def verify_config(env)
    verify "config/settings.example.yml"
  end

  def verify(example)
    copy_example(example) unless File.exists?(target_file_for(example))
  end
end
