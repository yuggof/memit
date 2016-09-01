require 'pathname'
require 'json'
require 'thor'
require 'csv'

require_relative './memit/cli'
require_relative './memit/config'
require_relative './memit/config_repository'
require_relative './memit/question_provider'

module Memit
  def self.root_path
    @root_path ||= Pathname.new(__dir__).parent
  end

  def self.config_path
    @config_path ||= Pathname.new(File.expand_path('~/.memit'))
  end
end
