begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "roles_for_dm"
    gem.summary = %Q{Faciliatates adding a role strategy to your Data Mapper user model}
    gem.description = %Q{Faciliatates adding a role strategy to your Data Mapper user model}
    gem.email = "kmandrup@gmail.com"
    gem.homepage = "http://github.com/kristianmandrup/roles_for_dm"
    gem.authors = ["Kristian Mandrup"]
    gem.add_development_dependency "rspec", ">= 2.0.0.beta.19"

    gem.add_dependency "dm-core",       "~> 1.0"
    gem.add_dependency "dm-types",      "~> 1.0"
    gem.add_dependency "dm-migrations", "~> 1.0"

    gem.add_dependency "active_support",    "~> 3.0.0"
    gem.add_dependency "require_all",       '~> 1.1.0' 
    gem.add_dependency "sugar-high",        '~> 0.2.3'
    gem.add_dependency "roles_generic",     '~> 0.2.2'
    
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

