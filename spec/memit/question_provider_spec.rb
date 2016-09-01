require_relative '../../lib/memit'

RSpec.describe Memit::QuestionProvider do
  describe '#random_question' do
    it 'returns random question and answer from data file' do
      CSV.open('data.csv', 'w', col_sep: ';') do |csv|
        csv << ['Does it work?', 'Yes']
      end
      qp = Memit::QuestionProvider.new('data.csv')

      q, a = qp.random_question

      expect(q).to eql 'Does it work?'
      expect(a).to eql 'Yes'

      File.delete('data.csv')
    end
  end
end
