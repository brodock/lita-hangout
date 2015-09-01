Gem::Specification.new do |spec|
  spec.name          = 'lita-hangout'
  spec.version       = '0.2.0'
  spec.authors       = ['Gabriel Mazetto']
  spec.email         = ['brodock@gmail.com']
  spec.description   = 'Generates Google+ Hangout URL for GoogleApps'
  spec.summary       = 'Google+ Hangout URL generator'
  spec.homepage      = 'http://github.com/brodock/lita-hangout'
  spec.license       = 'MIT'
  spec.metadata      = { 'lita_plugin_type' => 'handler' }

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'lita', '>= 4.6'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rspec', '>= 3.0.0'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rubocop'
end
