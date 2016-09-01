require_relative '../../lib/memit'

RSpec.describe Memit::ConfigRepository do
  describe '#save' do
    it 'saves config to a file' do
      cr = Memit::ConfigRepository.new('.memit')
      c = Memit::Config.new('data.csv')

      cr.save(c)

      expect(File.read('.memit')).to eql({data_path: 'data.csv'}.to_json)
    end
  end

  describe '#load' do
    context 'when config file does not exist' do
      it 'returns default config values' do
        File.delete('.memit') rescue nil
        cr = Memit::ConfigRepository.new('.memit')

        c = cr.load

        expect(c.data_path).to eql Memit::Config.default.data_path
      end
    end

    context 'when config file exists' do
      context 'when file is a valid json' do
        it 'loads config from that file' do
          File.open('.memit', 'w') do |f|
            f.write({data_path: 'data.csv'}.to_json)
          end
          cr = Memit::ConfigRepository.new('.memit')

          c = cr.load

          expect(c.data_path).to eql 'data.csv'
        end
      end

      context 'when file is an invalid json' do
        it 'raises Memit::ConfigRepository::UnparsableConfigFileError' do
          File.open('.memit', 'w') do |f|
            f.write('somethingreallybadanddefinetlynotajson')
          end
          cr = Memit::ConfigRepository.new('.memit')

          ec = Memit::ConfigRepository::UnparsableConfigFileError
          expect { cr.load }.to raise_error ec

          File.delete('.memit')
        end
      end
    end
  end
end
