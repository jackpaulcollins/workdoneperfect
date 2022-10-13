def load_development_seeds(name)
  load(File.join(Rails.root, "db", "seeds", "#{name}.seeds.rb"))
end

load_development_seeds("users")
load_development_seeds("employee_templates")
load_development_seeds("employee_attributes")
load_development_seeds("employees")
load_development_seeds("customers")
load_development_seeds("jobs")
load_development_seeds("employee_jobs")
