require 'optparse'

# What does a command line application need to do?
#	1. 
# This module serves as a mixin for Ruby Command Line Applications (CLI).
# Ruby commands can be written much easier by including this class and following
# the convention that I have outlined here.
#
# This is the core algorithm of any Ruby CLI application.
# def run
#   if parse_options? && arguments_valid?
#		process_options
#     process_arguments
#     output_options_and_arguments if @default_options[:verbose]
#     command
#   else
#     output_help(1)
#   end
#  end
module RubyCLI

	# Initialization of this application requires the command line arguments.
	def initialize(default_argv)
		@default_argv = default_argv
		@default_options = {:help => false, :verbose => false}
		@arguments = {}
		@options = {}
		@opt_parser = nil
	end

	# Run the application
  def run
    if parse_options? && arguments_valid?
			process_options
      process_arguments
      output_options_and_arguments if @default_options[:verbose]
      command
    else
      output_help(1)
    end
  end
	
	# Parse the options
	def parse_options?
		raise "This method should be overwritten." 
		#configure an OptionParser
		@opt_parser = OptionParser.new do |opts|		
			opts.banner = "Usage: #{__FILE__} [OPTIONS]... [FILE]..."
			opts.separator ""
			opts.separator "Specific options:"
			opts.on('-h', '--help', 'displays help information') do
				@default_options[:help] = true
				output_help(0)
			end
			opts.on('-V','--verbose','Run verbosely') do 
				@default_options[:verbose] = true
			end
			# ADD command specific options here
		end
		@opt_parser.parse!(@arguments) rescue return false
		true
	end

	# Check if the required number of arguments remains in the 
	# argv array after it has been processed by the option parser
	def arguments_valid?() 
		return true if @arguments.size == 0
		@default_argv.size == @arguments.size 
	end

	def output_options_and_arguments
    puts "OPTIONS:"
    @options.each {|name, value| puts "\t#{name} = #{value}"}
		puts "\tNo options" if @options.length == 0
		
		puts "ARGUMENTS:"
    @arguments.each {|name,value| puts "\t#{name} = #{value}"}
		puts "\tNo arguments" if @arguments.length == 0
  end

	# Performs post-parse processing on options
	# For instance, some options may be mutually exclusive
	def process_options() raise "This method should be overwritten." end	
	def process_arguments() raise "This method should be overwritten." end
	# Application logic
	
	def command() raise "This method should be overwritten." end
	
	def output_help(exit_code) 
		puts @opt_parser
		puts exit_code if @default_options[:verbose]
		return exit_code 
	end
	
end # Application
