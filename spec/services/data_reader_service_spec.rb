require 'rails_helper'

RSpec.describe DataReaderService do
  let(:data) do
    [{ 'Name' => 'A+',
       'Type' => 'Array',
       'Designed by' => 'Arthur Whitney' },
     { 'Name' => 'ActionScript',
       'Type' => 'Compiled, Curly-bracket, Procedural, Reflective, Scripting, Object-oriented class-based',
       'Designed by' => 'Gary Grossman' }]
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
