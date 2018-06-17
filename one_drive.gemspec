
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "one_drive/version"

Gem::Specification.new do |spec|
  spec.name          = "one_drive"
  spec.version       = OneDrive::VERSION
  spec.authors       = ["Mohit"]
  spec.email         = ["mohitdutta@live.com"]

  spec.summary       = %q{A ruby gem to connect with your Microsoft One Drive and read and write the files.}
  spec.description   = %q{A ruby gem to connect with your Microsoft One Drive and read and write the files.}
  spec.homepage      = "https://github.com/DimoMohit/onedrive"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = ""
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.11"
  spec.add_development_dependency 'activesupport',">4.0.13"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency "httparty"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "aruba"
  spec.add_development_dependency "test-unit"
  spec.add_development_dependency "test-unit-capybara"
  spec.add_development_dependency 'rspec'
end
