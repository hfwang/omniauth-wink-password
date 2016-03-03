# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth/wink/password/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-wink-password"
  spec.version       = Omniauth::Wink::Password::VERSION
  spec.authors       = ["Hsiu-Fan Wang"]
  spec.email         = ["hfwang@porkbuns.net"]

  spec.summary       = %q{Wink (password grant) strategy for OmniAuth.}
  spec.description   = %q{OmniAuth 1.x strategy that asks the user to log in with their Wink credentials.}
  spec.homepage      = "https://github.com/hfwang/omniauth-wink-password"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'omniauth', '~> 1.0'
  spec.add_dependency 'omniauth-oauth2', '~> 1.1'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
