# frozen_string_literal: true

require_relative "lib/money_bank_twelvedata_api/version"

Gem::Specification.new do |spec|
  spec.name          = "money_bank_twelvedata_api"
  spec.version       = MoneyBankTwelvedataApi::VERSION
  spec.authors       = ["Kendo Camajalan, kcd"]
  spec.email         = ["ken.d.camajalan@pm.me"]

  spec.summary       = "A gem that returns TwelveData API's real-time forex and 
    crypto exchange rate that is compatible with Money gem"  
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/kanroyalhigh/money-bank-twelvedata-api"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.4.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] =  "#{spec.metadata["source_code_uri"]}/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  spec.add_dependency "money", "~> 6.16", ">= 6.16.0"
  spec.add_dependency "twelvedata_ruby", "~> 0.3", ">= 0.3.0"
  
  spec.add_development_dependency "rake", "~> 13.0", ">= 13.0.0"
  spec.add_development_dependency "rspec", "~> 3.10", ">= 3.10.0"
  spec.add_development_dependency "rubocop", "~> 1.17", ">= 1.17.0"
  spec.add_development_dependency "simplecov", "~> 0.21", ">= 0.21.2"
end
