require_relative '../memit'

module Memit
  class ConfigRepository
    class UnparsableConfigFileError < StandardError
    end

    def initialize(config_path)
      @config_path = config_path
    end

    def save(config)
      File.open(@config_path, 'w') do |f|
        h = {data_path: config.data_path}
        f.write(h.to_json)
      end
    end

    def load
      if File.exist?(@config_path)
        h = JSON.parse(File.read(@config_path))
        Memit::Config.new(h['data_path'])
      else
        Memit::Config.default
      end

    rescue JSON::ParserError
      raise UnparsableConfigFileError
    end
  end
end
