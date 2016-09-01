require_relative '../memit'

module Memit
  class CLI < Thor
    desc 'askme', 'Asks a single question'
    def askme
      c = config_repository.load
      qp = Memit::QuestionProvider.new(c.data_path)
      q, a = qp.random_question

      puts q
      if STDIN.gets.chomp == a
        puts 'Correct!'
      else
        puts "Wrong! Should be '#{a}'."
      end
    end

    desc 'setdata', 'Sets data'
    def setdata(path)
      unless File.exist?(path)
        puts 'Data file does not exist.'
        return
      end

      c = config_repository.load

      c.data_path = path
      config_repository.save(c)
    end

    desc 'whichdata', 'Prints'
    def whichdata
      c = config_repository.load

      puts c.data_path
    end

    private

    def config_repository
      @config_repository ||= Memit::ConfigRepository.new(Memit.config_path)
    end
  end
end
