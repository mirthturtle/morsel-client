Gem::Specification.new do |s|
  s.name         = 'morsel-client'
  s.version      = '0.0.1'
  s.date         = '2019-07-23'
  s.summary      = "Manage your kitchen on the command line!"
  s.description  = "A command-line client for the m3lon kitchen management platform."
  s.authors      = ["Christian DeWolf"]
  s.email        = 'me@christiandewolf.com'
  s.files        = Dir["{lib}/**/*.rb", "bin/*", "*.md"]
  s.require_path = 'lib'
  s.homepage     = "https://www.m3lon.com/"
  s.executables  << 'morsel'
end
