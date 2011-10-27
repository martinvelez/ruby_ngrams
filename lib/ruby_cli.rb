require 'optparse'

# This is the actual command of this CLI app
# A CLI app should not have to validate options and arguments.
# This work needs to be delegated to the library that will use
# the options and arguments.
# A CLI app needs to run command instructions which call at 
# least one class or library to do the actual work.

class RubyCLI

	attr_accessor :options
	attr_reader :opt_parser
	
	def initialize(default_argv, arguments = {}, command) 
		@default_argv = default_argv 
		@options = {:help => false, :verbose => false}
		@arguments = arguments
		@opt_parser = @opt_parser = OptionParser.new do |opts|
			opts.banner = "Usage: #{__FILE__} [options] INFILE"
			opts.separator ""
			opts.separator "Specific options:"	
		end
		@command = command
	end

	# Run the application
  def run
    if parsed_options? && arguments_valid?
			process_options
      process_arguments
      (output_options; output_arguments) if @options[:verbose]
      process_command
    else
      output_help(1)
    end
  end
	
	# Parse the options
	def parsed_options?
		#We need to parse the command line
		@opt_parser.on('-h', '--help', 'Displays help information') do
			@options[:help] = true
			output_help(0)
		end
		@opt_parser.on('-V','--verbose','Run verbosely') do
			@options[:verbose] = true 
		end
		@opt_parser.parse!(@default_argv) rescue return false
		true
	end

	# Check if the required number of arguments remains in the 
	# argv array after it has been processed by the option parser
	def arguments_valid?() @default_argv.size == @arguments.size end
	
	# Setup the arguments
	def process_arguments
		@arguments.each do |key, value|
			@arguments[key] = @default_argv.shift	
		end
		true
	end
	
	# Performs post-parse processing on options
	# For instance, some options may cancel others or have higher importance
	def process_options()	true end	
	
	def process_command
		@command.call(@options, @arguments)
		exit 0
	end

  def output_help(exit_code) puts @opt_parser; return exit_code end

	def output_options
    puts "OPTIONS:"
    @options.each {|name, value| puts "\t#{name} = #{value}"}
		puts "\tNo options" if @options.length == 0
  end

  def output_arguments
    puts "ARGUMENTS:"
    @arguments.each {|name,value| puts "\t#{name} = #{value}"}
		puts "\tNo arguments" if @arguments.length == 0
  end

end # Application
