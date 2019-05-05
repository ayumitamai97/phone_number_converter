lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "phone_number_converter/version"

Gem::Specification.new do |spec|
  spec.name          = "phone_number_converter"
  spec.version       = PhoneNumberConverter::VERSION
  spec.authors       = ["ayumitamai97"]
  spec.email         = ["ayumitamai97@gmail.com"]

  spec.summary       = 'Easily convert phone number from global to domestic, or vice versa.'
  spec.description   = 'Easily convert phone number from global to domestic, or vice versa. Require Ruby >= 2.1.'
  spec.homepage      = "https://github.com/ayumitamai97/phone_number_converter"
  spec.license       = "MIT"
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '~> 2.1'
end
