class Ngram
	include Enumerable

	attr_reader :ngrams
	def initialize(string, n, unit)
		@string = string
		@n = n
		@unit = unit
		@ngrams = []
		generate
	end

	def generate  
		max_pos = @string.length - @n 
		for i in 0..max_pos
			@ngrams.push(@string[i..i+(@n-1)])	
		end
	end	

	def each
		@ngrams.each do |ngram|
			yield ngram
		end	
	end
end

