require_relative '../memit'

module Memit
  class Config
    def self.default
      new(Memit.root_path.join('data', 'prepositions.csv'))
    end

    attr_accessor :data_path

    def initialize(data_path)
      @data_path = data_path
    end
  end
end
