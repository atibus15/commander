# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "commander/version"

Gem::Specification.new do |spec|
  spec.name          = "commander"
  spec.version       = Commander::VERSION
  spec.authors       = ["Adamson Ibus"]
  spec.email         = ["adamson.ibus@gmail.com"]

  spec.summary       = %q{Kiosk Commander.}
  spec.description   = %q{Use to command touchmedia kiosks.}
  spec.homepage      = "https://www.facebook.com/adamson0915"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "http://rubygems.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "net-ssh"
end
