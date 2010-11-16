require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "i18n_emails"
    gem.summary = %Q{The nicer way to create and maintain emails in Rails apps using I18n}
    gem.description = %Q{I18nEmails makes it easy to create and maintain I18n emails in Rails apps.

    Using I18n in large Rails apps often results in large and incomprehensible translation files. The idea of splitting up concerns should also apply to translations files and emails in particular and that is why this gem was created.

    I18nEmails allows you to create separate translation files for each email (.email) and store them in a nested folder structure mirroring a translation file, for example: config/locales/en/notifier/forgotten_password.email.

    The email body content in a .email file is also more readable for both developer and non-technical people then a YAML file. }
    gem.email = "mattvague@gmail.com"
    gem.homepage = "http://github.com/mattvague/i18n_emails"
    gem.authors = ["Matt Vague", "Greg Bell", "VersaPay"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "i18n_emails #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
