require 'rails_helper'

RSpec.describe DataReaderService do
  let(:data) do
    [{ NAME => 'A+',
       TYPE => 'Array',
       DESIGNED_BY => 'Arthur Whitney' },
     { NAME => 'ActionScript',
       TYPE => 'Compiled, Curly-bracket, Procedural, Reflective, Scripting, Object-oriented class-based',
       DESIGNED_BY => 'Gary Grossman' }]
  end

  before do
    stub_const('JSON_FILE_PATH', 'spec/data/data.json')
  end

  describe '#call' do
    it 'returns parsed data' do
      expect(described_class.call).to eq(data)
    end
  end
end
