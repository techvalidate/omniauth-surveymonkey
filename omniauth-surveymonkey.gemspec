Gem::Specification.new do |s|
  s.name        = 'omniauth-surveymonkey'
  s.version     = '0.0.1'
  s.date        = '2016-04-13'
  s.authors     = ['Jordan McKible']
  s.email       = 'jordanm@surveymonkey.com'
  s.license     = 'MIT'

  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'faraday'
  gem.add_dependency 'multi_json'
end
