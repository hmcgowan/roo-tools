# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{roo-tools}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Hugh McGowan"]
  s.date = %q{2009-03-09}
  s.default_executable = %q{oogrep}
  s.description = %q{Tools using roo to performa actions on multiple spreadsheets}
  s.email = %q{hugh_mcgowan@yahoo.com}
  s.executables = ["oogrep"]
  s.extra_rdoc_files = ["README"]
  s.files = ["lib/roo-tools", "lib/roo-tools/grep.rb", "lib/roo-tools.rb", "bin/oogrep", "README"]
  s.has_rdoc = true
  s.homepage = %q{}
  s.rdoc_options = ["--main", "README", "--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{roo-tools}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{roo-tools}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<roo>, [">= 1.2.3"])
      s.add_runtime_dependency(%q<user-choices>, [">= 1.1.6"])
    else
      s.add_dependency(%q<roo>, [">= 1.2.3"])
      s.add_dependency(%q<user-choices>, [">= 1.1.6"])
    end
  else
    s.add_dependency(%q<roo>, [">= 1.2.3"])
    s.add_dependency(%q<user-choices>, [">= 1.1.6"])
  end
end
