# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name        = 'omniauth-surveymonkey'
  gem.version     = '0.0.1'
  gem.date        = '2016-04-13'
  gem.authors     = ['Jordan McKible']
  gem.email       = 'jordanm@surveymonkey.com'
  gem.license     = 'MIT'

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.require_paths = ['lib']

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'faraday'
  gem.add_dependency 'multi_json'
end
