class Main
  get "/" do
    @configs = monk_settings(:database)
    haml :home
  end
end
