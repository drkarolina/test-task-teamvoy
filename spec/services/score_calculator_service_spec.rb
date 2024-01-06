require 'rails_helper'

RSpec.describe ScoreCalculatorService do
  let(:data_sample_without_exact_match) do
    { 'Name' => 'A+',
      'Type' => 'Array',
      'Designed by' => 'Microsoft Whitney' }
  end
  let(:data_sample_with_exact_match) do
    { 'Name' => 'A+',
      'Type' => 'Array',
      'Designed by' => 'Microsoft' }
  end
  let(:searched_word) { ['microsoft'] }

  describe '#calculate' do
    context 'without exact macth' do
      let(:result) do
        described_class.calculate(data_sample_without_exact_match, searched_word)
      end

      it 'returns 0' do
        expect(result).to eq(0)
      end
    end

    context 'with exact macth' do
      let(:result) do
        described_class.calculate(data_sample_with_exact_match, searched_word)
      end

      it 'returns 1' do
        expect(result).to eq(1)
      end
    end
  end
end
