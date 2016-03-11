Gem::Specification.new do |s|
  s.name        = 'parslet-ext'
  s.version     = '0.0.1'
  s.license     = 'GPLv3'

  s.summary     = 'Extensions to the Parslet parsing library'
  s.description = 'Adds some useful functions to Parlset which the author has decided not include in the core'

  s.authors     = ['Michael Mior']
  s.email       = 'michael.mior@gmail.com'
  s.files       = Dir.glob 'lib/**/*.rb'
  s.homepage    = 'https://github.com/michaelmior/parslet-ext'

  s.add_runtime_dependency 'parslet', '~> 1.7'
end
