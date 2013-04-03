# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_one_page_checkout'
  s.version     = '1.0.0'
  s.summary     = 'One page checkout implementation for spree'
  s.description = 'One page checkout implementation for spree'
  s.required_ruby_version = '>= 1.9.2'

  s.author    = 'Racoons Group'
  s.email     = 'contact@racoons-group.com'
  s.homepage  = 'http://racoons-group.com'

  s.files        = Dir['LICENSE', 'README.md', 'app/**/*', 'config/**/*', 'lib/**/*', 'db/**/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.3.0'
  s.add_dependency 'ejs'

  s.add_development_dependency 'capybara', '~> 2.0.2'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'factory_girl_rails', '~> 4.2.0'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.9'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'sqlite3'
end
