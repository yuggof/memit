Gem::Specification.new do |s|
  s.name = 'memit'
  s.version = '0.0.2'
  s.summary = 'Do you have to memorize something? Memit can help you!'
  s.date = '2016-06-11'
  s.authors = ['Piotr Leniec']
  s.email = 'leniec.piotr@gmail.com'
  s.license = 'MIT'
  s.files = %w[
    lib/memit.rb
    lib/memit/cli.rb
    lib/memit/config.rb
    lib/memit/config_repository.rb
    lib/memit/question_provider.rb

    data/prepositions.csv
  ]
  s.executables << 'memit'

  s.add_runtime_dependency 'thor', '0.19.1'
  s.add_development_dependency 'rspec', '3.5.0'
end
