require 'rails_helper'

RSpec.describe QueryWordsService do
  let(:query) do
    '-nagative "quotation marks" positive -morenegative "exact search quotation marks"
     -"negative exact search quotation marks" pluspositive'
  end
  let(:negative_search_words) { ['negative exact search quotation marks', 'nagative', 'morenegative'] }
  let(:positive_search_words) { ['quotation marks', 'exact search quotation marks', 'positive', 'pluspositive'] }
  let(:instance) { described_class.new(query) }

  describe '#negative_search_words' do
    it 'returns words array for negative search' do
      expect(instance.negative_search_words).to eq(negative_search_words)
    end
  end

  describe '#positive_search_words' do
    it 'returns words array for positive search' do
      expect(instance.positive_search_words).to eq(positive_search_words)
    end
  end
end
