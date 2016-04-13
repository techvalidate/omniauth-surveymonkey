Gem::Specification.new do |gem|
  gem.name        = 'omniauth-surveymonkey'
  gem.version     = '0.0.1'
  gem.date        = '2016-04-13'
  gem.authors     = ['Jordan McKible']
  gem.email       = 'jordanm@surveymonkey.com'
  gem.license     = 'MIT'

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'faraday'
  gem.add_dependency 'multi_json'
end
