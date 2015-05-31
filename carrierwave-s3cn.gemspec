# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carrierwave/s3cn/version'

Gem::Specification.new do |spec|
  spec.name          = "carrierwave-s3cn"
  spec.version       = CarrierWave::S3cn::VERSION
  spec.authors       = ["xudeke"]
  spec.email         = ["xudeke@gmail.com"]
  spec.summary       = %q{S3 storage, in china, plugin for CarrierWave }
  spec.description   = %q{S3 storage, in china, plugin for CarrierWave}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "carrierwave"
  spec.add_dependency "aws-sdk-v1"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
