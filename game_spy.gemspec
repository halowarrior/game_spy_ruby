# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'game_spy/version'

Gem::Specification.new do |spec|
  spec.name          = "game_spy"
  spec.version       = GameSpy::VERSION
  spec.authors       = ["Adam Hallett"]
  spec.email         = ["adam.t.hallett@gmail.com"]

  spec.summary       = %q{Game Spy}
  spec.description   = %q{Game Spy}
  spec.homepage      = "https://github.com/halowarrior/game_spy_ruby"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rspec", "~> 3.4.0"
  spec.add_dependency "rake", "~> 10.0"
  spec.add_dependency "ffi", "~> 1.9.10"

  spec.extensions =  [
    'ext/Rakefile',

  ]
end
