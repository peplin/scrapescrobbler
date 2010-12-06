module Scrapescrobbler
  module Config
    extend self
    PATH = ENV['SCRAPESCROBBLER_CONFIG_FILE'] || File.join(ENV['HOME'], '.scrapescrobbler.yml')

    # Application defaults.
    #
    # These are written to a config file by invoking:
    # <code>
    # t configure
    # </code>
    def defaults
      {
        # Path to the sqlite db
        'database_file' => "#{ENV['HOME']}/.scrapescrobbler.db",
        'api_key' => "73af75e07cd58bfe66d13af9371b9504",
        'api_secret' => "85b1b415e9c2b653e84bd1304d4dd9fa",
        'token' => nil
      }
    end

    def [](key)
      overrides = File.exist?(PATH) ? YAML.load(File.read(PATH)) : {}
      defaults.merge(overrides)[key]
    rescue => e
      puts "invalid config file"
      puts e.message
      defaults[key]
    end

    def configure!
      unless File.exist?(PATH)
        File.open(PATH, 'w') do |fh|
          fh.puts(defaults.to_yaml)
        end
      end
    end

    def update! values
      File.open(PATH, 'w') do |fh|
        fh.puts(defaults.update(values).to_yaml)
      end
    end
  end
end
