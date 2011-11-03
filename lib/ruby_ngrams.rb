
#This is an extension of Ruby's core String class.
#It add methods to extract a set of n-grams from a string.
class String

	#An N-gram is a sequence of N units, or tokens, of text, where those units are 
	#typically single characters or strings that are delimited by spaces.
	#However, a token could also be a fixed length character sequence, strings 
	#with embedded spaces, etc. depending on the intended application.
	#Typically, n-grams formed of contiguous tokens.
	#
	#regex
	#	// => character
	#	/\W/ => word, ignore punctuaction
	
	def ngrams(options = {:split_regex=>//, :n=>1})
		
		tokens = self.split(options[:split_regex])
		ngrams = []
				
		max_pos = tokens.length - options[:n]
		for i in 0..max_pos
			ngrams.push(tokens[i..i+(options[:n]-1)])
		end
		ngrams
	end
	
	def unigrams(options = {:split_regex=>//, :n => 1}) 
		ngrams(options)
	end
	
	def bigrams(options = {:split_regex=>//, :n => 2}) 
		ngrams(options)
	end
	
	def trigrams(options = {:split_regex=>//, :n => 3}) 
		ngrams(options)
	end

end #class String


