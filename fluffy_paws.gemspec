# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fluffy_paws/version'

Gem::Specification.new do |spec|
  spec.name          = "fluffy_paws"
  spec.version       = FluffyPaws::VERSION
  spec.authors       = ["Eriks Ocakovskis"]
  spec.email         = ["e.ocakovskis@gmail.com"]

  spec.summary       = %q{Ruby project for I704.}
  spec.description   = %q{A website using Sinatra for Estonian IT College I704 class.}
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = ""
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

  spec.required_ruby_version = '~> 2.0'
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.5"
  spec.add_development_dependency "minitest", "~> 5.10"
  spec.add_dependency "sinatra"
  spec.add_dependency 'haml'
  spec.add_dependency 'pg'
  spec.add_dependency 'sequel_pg'
  spec.add_dependency 'sequel'
  spec.add_dependency 'rack-test'
  spec.add_dependency 'bcrypt'
end
