# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "rbpdf"
  s.version = "1.19.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["NAITOH Jun"]
  s.date = "2015-11-20"
  s.description = "A template plugin allowing the inclusion of ERB-enabled RBPDF template files."
  s.email = ["naitoh@gmail.com"]
  s.homepage = ""
  s.licenses = ["LGPL 2.1 or later"]
  s.rdoc_options = ["--exclude", "lib/fonts/", "--exclude", "lib/htmlcolors.rb", "--exclude", "lib/unicode_data.rb"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubygems_version = "2.0.14.1"
  s.summary = "RBPDF via TCPDF."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<htmlentities>, ["= 4.3.1"])
      s.add_runtime_dependency(%q<rbpdf-font>, ["~> 1.19.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.6"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, ["~> 3.0"])
    else
      s.add_dependency(%q<htmlentities>, ["= 4.3.1"])
      s.add_dependency(%q<rbpdf-font>, ["~> 1.19.0"])
      s.add_dependency(%q<bundler>, ["~> 1.6"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<test-unit>, ["~> 3.0"])
    end
  else
    s.add_dependency(%q<htmlentities>, ["= 4.3.1"])
    s.add_dependency(%q<rbpdf-font>, ["~> 1.19.0"])
    s.add_dependency(%q<bundler>, ["~> 1.6"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<test-unit>, ["~> 3.0"])
  end
end
