class Main
  get "/" do
    @postgresql = monk_settings(:postgresql)
    haml :home
  end
end
