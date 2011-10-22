module Ngrams

	def self.extract(string, n, unit) 
		ngrams = []
		max_pos = string.length - n 
		for i in 0..max_pos
			ngrams.push(string[i..i+(n-1)])	
		end
		ngrams
	end	

	#module_function :extract
end #module
