require 'rails_helper'

RSpec.describe QueryWordsService do
  let(:query) do
    '-nagative "quotation marks" positive -morenegative "exact search quotation marks"
     -"negative exact search quotation marks" pluspositive'
  end
  let(:positive_search) { %w[positive pluspositive] }
  let(:negative_search) { %w[nagative morenegative] }
  let(:exact_search) { ['quotation marks', 'exact search quotation marks'] }
  let(:negative_exact_search) { ['negative exact search quotation marks'] }
  let(:instance) { described_class.new(query) }

  describe '#exact_search' do
    it 'returns words array for exact search' do
      expect(instance.exact_search).to eq(exact_search)
    end
  end

  describe '#negative_exact_search' do
    it 'returns words array for exact search' do
      expect(instance.negative_exact_search).to eq(negative_exact_search)
    end
  end

  describe '#positive_search' do
    it 'returns words array for exact search' do
      expect(instance.positive_search).to eq(positive_search)
    end
  end

  describe '#negative_search' do
    it 'returns words array for exact search' do
      expect(instance.negative_search).to eq(negative_search)
    end
  end
end
