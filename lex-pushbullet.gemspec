# frozen_string_literal: true

require_relative 'lib/legion/extensions/pushbullet/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-pushbullet'
  spec.version       = Legion::Extensions::Pushbullet::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX::Pushbullet'
  spec.description   = 'LEX::Pushbullet'
  spec.homepage      = 'https://github.com/LegionIO/lex-pushbullet'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/LegionIO/lex-pushbullet'
  spec.metadata['documentation_uri'] = 'https://github.com/LegionIO/lex-pushbullet'
  spec.metadata['changelog_uri'] = 'https://github.com/LegionIO/lex-pushbullet'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/LegionIO/lex-pushbullet/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 2'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
end
