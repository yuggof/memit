require_relative '../memit'

module Memit
  class QuestionProvider
    def initialize(data_path)
      @data_path = data_path
    end

    def random_question
      data.sample
    end

    private

    def data
      @data ||= CSV.read(@data_path, col_sep: ';', row_sep: "\n", encoding: 'utf-8')
    end
  end
end
