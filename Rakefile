begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "roles_data_mapper"
    gem.summary = %Q{Implementation of Roles generic API for DataMapper}
    gem.description = %Q{Makes it easy to set a role strategy on your User model in DataMapper}
    gem.email = "kmandrup@gmail.com"
    gem.homepage = "http://github.com/kristianmandrup/roles_for_dm"
    gem.authors = ["Kristian Mandrup"]
    gem.add_development_dependency "rspec",           ">= 2.0.1"
    gem.add_development_dependency "generator-spec",  '>= 0.7.0'

    gem.add_dependency "dm-core",         "~> 1.0"
    gem.add_dependency "dm-types",        "~> 1.0"
    gem.add_dependency "dm-migrations",   "~> 1.0"
    gem.add_dependency "dm-validations",  "~> 1.0"

    gem.add_dependency "activesupport",     ">= 3.0.1"
    gem.add_dependency "require_all",       '~> 1.2.0' 
    gem.add_dependency "sugar-high",        '>= 0.3.1'
    gem.add_dependency "roles_generic",     '>= 0.3.2'

    gem.add_dependency 'rails3_artifactor', '>= 0.3.2'
    gem.add_dependency 'logging_assist',    '>= 0.2.0'
    
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

