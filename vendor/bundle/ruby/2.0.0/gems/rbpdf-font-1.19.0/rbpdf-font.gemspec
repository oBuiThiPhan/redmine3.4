# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rbpdf-font/version'

Gem::Specification.new do |spec|
  spec.name          = "rbpdf-font"
  spec.version       = RBPDFFontDescriptor::VERSION
  spec.authors       = ["NAITOH Jun"]
  spec.email         = ["naitoh@gmail.com"]
  spec.summary       = %q{RBPDF Font.}
  spec.description   = %q{RBPDF font files.}
  spec.homepage      = ""
  spec.files         = Dir.glob("lib/version.rb") +
                       Dir.glob("lib/rbpdf-font.rb") +
                       Dir.glob("lib/fonts/*.{rb,z}") +
                       Dir.glob("lib/fonts/freefont-*/*") +
                       Dir.glob("lib/fonts/dejavu-fonts-ttf-*/{AUTHORS,BUGS,LICENSE,NEWS,README}") +
                       Dir.glob("lib/fonts/ttf2ufm/*.TXT") +
                       Dir.glob("lib/fonts/ttf2ufm/*.rb") +
                       Dir.glob("lib/fonts/ttf2ufm/ttf2ufm") +
                       Dir.glob("lib/fonts/ttf2ufm/enc/*") +
                       Dir.glob("test/*") +
                       ["Rakefile", "rbpdf-font.gemspec",
                        "CHANGELOG", "MIT-LICENSE"]
  spec.rdoc_options  += [ '--exclude', 'lib/fonts/' ]

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit", "~> 3.0"
end
