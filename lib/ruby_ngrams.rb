
#This is an extension of Ruby's core String class.
#It add methods to extract a set of n-grams from a string.
class String

	#An N-gram is a sequence of N units, or tokens, of text, whre those units are 
	#typically single characters or strings that are delimited by spaces.
	#However, a token could also be a fixed length character sequence, strings 
	#with embedded spaces, etc. depending on the intended application.
	#Typically, n-grams formed of contiguous tokens.
	def ngrams(options = {:unit => "char", :ignore_punctuation => false, :n => 1})
		unit_types = ["char","c", "word","w", "line","l"]
		
		raise "unit type must be in #{unit_types.inspect}" unless unit_types.include?(options[:unit])
		
		tokens = self.tokenize(unit, options[:ignore_punctuation])
		ngrams = []
				
		max_pos = tokens.length - options[:n]
		for i in 0..max_pos
			ngrams.push(tokens[i..i+(options[:n]-1)])
		end
		ngrams
	end
	
	def tokenize(options = {:unit => "char", :ignore_punctuation => false})
		tokens = []
		case unit
		when "char", "c"
			tokens = self.split(//)
		when "word", "w"
			tokens = self.split(/\s+/)
		when "line", "l"
			self.each_line do |line|
				tokens << line
			end
		end
		puts tokens.inspect
		return tokens
	end
	
	def unigrams(unit) ngrams(options = {:unit => "char", :ignore_punctuation => false, :n => 1}); end
	def bigrams(unit) ngrams(options = {:unit => "char", :ignore_punctuation => false, :n => 2}); end
	def trigrams(unit) ngrams(options = {:unit => "char", :ignore_punctuation => false, :n => 3}); end
end


