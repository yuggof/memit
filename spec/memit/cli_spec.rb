require_relative '../../lib/memit'

RSpec.describe Memit::CLI do
  describe '#askme' do
    context 'when provided answer is correct' do
      it 'prints "Correct!"' do
        CSV.open('data.csv', 'w', col_sep: ';') { |csv| csv << ['Does it work?', 'Yes it does!'] }
        File.open('.memit', 'w') { |f| f.write({data_path: 'data.csv'}.to_json) }
        c = Memit::CLI.new
        allow(c).to receive(:config_repository) { Memit::ConfigRepository.new('.memit') }
        allow(STDIN).to receive(:gets) { 'Yes it does!' }

        expect { c.askme }.to output("Does it work?\nCorrect!\n").to_stdout

        %w[.memit data.csv].each { |f| File.delete(f) }
      end
    end

    context 'when provided answer is wrong' do
      it 'prints "Wrong! Should be \'<correct answer>\'."' do
        CSV.open('data.csv', 'w', col_sep: ';') { |csv| csv << ['Does it work?', 'Yes it does!'] }
        File.open('.memit', 'w') { |f| f.write({data_path: 'data.csv'}.to_json) }
        c = Memit::CLI.new
        allow(c).to receive(:config_repository) { Memit::ConfigRepository.new('.memit') }
        allow(STDIN).to receive(:gets) { 'No idea!' }

        expect { c.askme }.to output("Does it work?\nWrong! Should be 'Yes it does!'.\n").to_stdout

        %w[.memit data.csv].each { |f| File.delete(f) }
      end
    end
  end

  describe '#setdata' do
    context 'when provided path points at file' do
      it 'changes data path' do
        File.open('data.csv', 'w') {}
        c = Memit::CLI.new
        allow(c).to receive(:config_repository) { Memit::ConfigRepository.new('.memit') }

        c.setdata('data.csv')

        dp = JSON.parse(File.read('.memit'))['data_path']
        expect(dp).to eql 'data.csv'
      end
    end

    context 'when provided path does not point at file' do
      it 'prints message and does not change data path' do
        %w[.memit data.csv].each { |f| File.delete(f) rescue nil }
        c = Memit::CLI.new
        allow(c).to receive(:config_repository) { Memit::ConfigRepository.new('.memit') }

        es = "Data file does not exist.\n"
        expect { c.setdata('data.csv') }.to output(es).to_stdout

        expect(File.exist?('.memit')).to be false
      end
    end
  end

  describe '#whichdata' do
    it 'prints current data path' do
      File.delete('.memit') rescue nil
      c = Memit::CLI.new
      allow(c).to receive(:config_repository) { Memit::ConfigRepository.new('.memit') }

      es = Memit::Config.default.data_path.to_s + "\n"
      expect { c.whichdata }.to output(es).to_stdout
    end
  end
end
