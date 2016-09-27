Gem::Specification.new do |gem|
  gem.name        = 'burdened-acrobat'
  gem.version     = `git describe --tags --abbrev=0`.chomp
  gem.licenses    = 'MIT'
  gem.authors     = ['Chris Olstrom']
  gem.email       = 'chris@olstrom.com'
  gem.homepage    = 'https://github.com/colstrom/burdened-acrobat'
  gem.summary     = 'Library for finding load balancers, when you have too many'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'aws-sdk', '~> 2.6', '>= 2.6.3'
  gem.add_runtime_dependency 'contracts', '~> 0.14', '>= 0.14.0'
end
