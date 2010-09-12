module Scrapescrobbler
  module CLI
    attr_accessor :args
    extend self

    USAGE = <<-EOF

Scrapescrobbler - Old-Fashioned Radio Station Scrobbling

Usage: #{File.basename $0} COMMAND [OPTIONS] [ARGS...]

where COMMAND is one of:
  * list - start scrobbling a radio station's playlist
    usage: t listen [STATION]
  * list - list all available stations
    usage: t list
  * configure - write out a config file. print path to config file.

    OTHER OPTIONS
    -h, --help              Display this help

    Submit bugs and feature requests to http://github.com/peplin/scrapescrobbler/issues
    EOF

    def parse arguments
      args.parse arguments
    end

    def invoke
      args['-h'] ? say(USAGE) : invoke_command_if_valid
    end

    def commands
      Scrapescrobbler::CLI::USAGE.scan(/\* \w+/).map{|s| s.gsub(/\* /, '')}
    end

    def say *something
      puts *something
    end

    def invoke_command_if_valid
      command = args.unused.shift
      set_global_options
      case (valid = commands.select{|name| name =~ %r|^#{command}|}).size
      when 0 then say "Invalid command: #{command}"
      when 1 then send valid[0]
      else
        say "Ambiguous command: #{command}" if command
        say(USAGE)
      end
    end

    # currently just sets whether output should be rounded to 15 min intervals
    def set_global_options
      Scrapescrobbler::Entry.round = true if args['-r']
    end

    private

    def unused_args
      args.unused.join(' ')
    end

    def ask_user question
      return true if args['-y']
      print question
      $stdin.gets =~ /\Aye?s?\Z/i
    end

  end
end
