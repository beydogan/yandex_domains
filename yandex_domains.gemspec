# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yandex_domains/version'

Gem::Specification.new do |spec|
  spec.name          = "yandex_domains"
  spec.version       = YandexDomains::VERSION
  spec.authors       = ["Mehmet Beydogan"]
  spec.email         = ["m@mehmet.pw"]

  spec.summary       = %q{Ruby client for Yandex.Mail for Domains API}
  spec.homepage      = "http://github.com/beydogan/yandex-domains"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "httparty", "~> 0.13.3"
end
