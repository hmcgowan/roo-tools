require 'roo'
require 'user-choices'
require 'roo-tools/grep'

module RooTools
  
  class RooGrepRunner < UserChoices::Command
    include UserChoices

    def initialize
     @seen = {}
     @matches = 0
     @matching_files = 0
     super
    end

    def add_sources(builder)
      builder.add_source(CommandLineSource, :usage, "Usage: oogrep.rb [options] searchstring targets")
    end
  
    def add_choices(builder)
      builder.add_choice(:list_only, :type=>:boolean, :default=>false) do | command_line |
        command_line.uses_option("-l", "--list-only", "List matching files only")
      end
      builder.add_choice(:case_insensitive, :type=>:boolean, :default=>false) do | command_line |
        command_line.uses_option("-i", "--case-insensitive", "Case insensitive search")
      end
      builder.add_choice(:exact_match, :type=>:boolean, :default=>false) do | command_line |
        command_line.uses_option("-e", "--exact-match", "Force exact match on cell contents")
      end
      builder.add_choice(:font, :type=>['bold','italic','underline','normal','ignore'], :default=>'ignore') do | command_line |
        command_line.uses_option("-f", "--font STYLE", "Filter results by cell font style")
      end
      builder.add_choice(:tabs, :type=>:boolean, :default=>true) do | command_line |
        command_line.uses_switch("--tabs", "Show/hide tabs in results")
      end
      builder.add_choice(:cells, :type=>:boolean, :default=>true) do | command_line |
        command_line.uses_switch("--cells", "Show/hide cells in results")
      end
      builder.add_choice(:recurse, :type=>:boolean, :default=>false) do | command_line |
        command_line.uses_switch("-r", "--recurse", "Search in subdirectories")
      end
      builder.add_choice(:files) { |command_line |
        command_line.uses_arglist
      }
    end
  
    def execute
      if @user_choices[:help]
        puts @user_choices[:usage]
        exit 0
      end
      @user_choices[:searchstring] = @user_choices[:files].shift
      puts 
      start_interrupt_handler
      oogrep = Grep.new(@user_choices)
      oogrep.process_files
      unless @user_choices[:list_only]
        puts "#{oogrep.matches} matches in #{oogrep.matching_files} file(s)"
      end
      return 0
    end
  
    def start_interrupt_handler
      trap "SIGINT", proc { puts "\nUser Interrupt...exiting" ; exit 1}
    end
    private :start_interrupt_handler
    
    def exit_gracefully
      exit 0
    end
    private :exit_gracefully
  
  end
end


