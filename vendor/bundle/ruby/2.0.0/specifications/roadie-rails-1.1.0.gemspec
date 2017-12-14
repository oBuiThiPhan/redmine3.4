# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "roadie-rails"
  s.version = "1.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Magnus Bergmark"]
  s.date = "2015-11-17"
  s.description = "Hooks Roadie into your Rails application to help with email generation."
  s.email = ["magnus.bergmark@gmail.com"]
  s.extra_rdoc_files = ["README.md", "Changelog.md", "LICENSE.txt"]
  s.files = ["README.md", "Changelog.md", "LICENSE.txt"]
  s.homepage = "http://github.com/Mange/roadie-rails"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.14.1"
  s.summary = "Making HTML emails comfortable for the Rails rockstars"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<roadie>, ["~> 3.1"])
      s.add_runtime_dependency(%q<railties>, ["< 4.3", ">= 3.0"])
      s.add_development_dependency(%q<rails>, ["< 4.3", ">= 3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.6"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 0"])
      s.add_development_dependency(%q<rspec-collection_matchers>, [">= 0"])
    else
      s.add_dependency(%q<roadie>, ["~> 3.1"])
      s.add_dependency(%q<railties>, ["< 4.3", ">= 3.0"])
      s.add_dependency(%q<rails>, ["< 4.3", ">= 3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.6"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<rspec-rails>, [">= 0"])
      s.add_dependency(%q<rspec-collection_matchers>, [">= 0"])
    end
  else
    s.add_dependency(%q<roadie>, ["~> 3.1"])
    s.add_dependency(%q<railties>, ["< 4.3", ">= 3.0"])
    s.add_dependency(%q<rails>, ["< 4.3", ">= 3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.6"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<rspec-rails>, [">= 0"])
    s.add_dependency(%q<rspec-collection_matchers>, [">= 0"])
  end
end
