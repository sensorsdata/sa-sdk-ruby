lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sensors_analytics/version'

Gem::Specification.new do |spec|
  spec.name        = 'sensors_analytics_sdk'
  spec.version     = SensorsAnalytics::VERSION
  spec.summary     = "SensorsAnalyticsSDK"
  spec.description = "This is the official Ruby SDK for Sensors Analytics."
  spec.authors     = ["Yuhan ZOU", "Vincent"]
  spec.email       = 'zouyuhan@sensorsdata.cn'

  spec.homepage    =  'https://github.com/sensorsdata/sa-sdk-ruby'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "mocha"
end
