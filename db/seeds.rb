def load_development_seeds(name)
  load(File.join(Rails.root, "db", "seeds", "#{name}.seeds.rb"))
end

load_development_seeds("users")
