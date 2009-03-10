$:.unshift('lib')
 
require 'rake/testtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name               = 'roo-tools'
    s.rubyforge_project  = 'roo-tools'
    s.platform           = Gem::Platform::RUBY
    s.email              = 'hugh_mcgowan@yahoo.com' 
    s.homepage           = ""
    s.summary            = "roo-tools"
    s.description        = "Tools using roo to performa actions on multiple spreadsheets"
    s.authors            = ['Hugh McGowan']
    s.files              =  FileList[ "{lib}/**/*"]
    s.executables        = ['oogrep']
    s.extra_rdoc_files   = ["README"]
    s.has_rdoc = true
    s.rdoc_options       = ["--main","README"]
    s.add_dependency "roo", [">= 1.2.3"]
    s.add_dependency "user-choices", [">= 1.1.6"]
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['spec/*.rb']
  t.verbose = true
end


task :default => :test