require 'rails_helper'

RSpec.describe ScoreCalculatorService do
  let(:data_sample_without_exact_match) do
    { NAME => 'New name',
      TYPE => 'Array',
      DESIGNED_BY => 'Microsoft Whitney' }
  end
  let(:data_sample_with_exact_match) do
    { NAME => 'Name new',
      TYPE => 'Array',
      DESIGNED_BY => 'Microsoft' }
  end
  let(:searched_word) { ['microsoft'] }
  let(:searched_name) { %w[name new] }

  describe '#call' do
    context 'without exact macth' do
      let(:result) do
        described_class.new(data_sample_without_exact_match, searched_word).call
      end

      it 'returns 0' do
        expect(result).to eq(0)
      end
    end

    context 'with macth in name' do
      let(:result) do
        described_class.new(data_sample_with_exact_match, searched_name).call
      end

      it 'returns 6' do
        expect(result).to eq(6)
      end
    end

    context 'with exact macth' do
      let(:result) do
        described_class.new(data_sample_with_exact_match, searched_word).call
      end

      it 'returns 1' do
        expect(result).to eq(1)
      end
    end
  end
end
