# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "activesupport-suspend_callbacks"
  spec.version       = "0.0.1"
  spec.authors       = ["Jacob Fugal"]
  spec.email         = ["jacob@instructure.com"]
  spec.summary       = "Temporarily suspend specific ActiveSupport::Callbacks callbacks"

  spec.files         = Dir.glob("{lib,spec}/**/*") + %w[LICENSE.txt Rakefile README.md test.sh]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 3.2"

  spec.add_development_dependency "bundler", "~> 2.2"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.5.0"
end
