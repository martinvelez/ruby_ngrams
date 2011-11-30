Gem::Specification.new do |s|
	s.name = 'ruby_ngrams'
	s.version = '0.0.3'
	s.executables = ['ruby_ngrams']
	s.date = '2011-11-29'
	s.summary = "Parses a string into n-grams"
	s.description = "A simple extension of the Ruby core string class to parse a string into n-grams"
	s.authors = ["Martin Velez"]
	s.email = 'mvelez999@gmail.com'
	s.files = Dir["{lib,bin}/**/*"] + ["README.rdoc"]
	s.homepage = 'http://github.com/martinvelez/ruby_ngrams'
	s.require_paths = ["bin", "lib"]
	s.add_dependency('ruby_cli', '>=0.1.0')
end
