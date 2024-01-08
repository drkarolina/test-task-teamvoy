require 'rails_helper'

RSpec.describe ResultsPresenter do
  let(:data) do
    [{ NAME => 'A+',
       TYPE => 'Array',
       DESIGNED_BY => 'Arthur Whitney',
       score: 1 },
     { NAME => 'ActionScript',
       TYPE => 'Compiled, Curly-bracket, Procedural, Reflective, Scripting, Object-oriented class-based',
       DESIGNED_BY => 'Gary Grossman',
       score: 0 }]
  end
  let(:scoreless_data) do
    [{ NAME => 'A+',
       TYPE => 'Array',
       DESIGNED_BY => 'Arthur Whitney' },
     { NAME => 'ActionScript',
       TYPE => 'Compiled, Curly-bracket, Procedural, Reflective, Scripting, Object-oriented class-based',
       DESIGNED_BY => 'Gary Grossman' }]
  end
  let(:presenter) { described_class.new(data) }

  describe '#results_count' do
    it 'returns result array length' do
      expect(presenter.results_count).to eq(data.count)
    end
  end

  describe '#results' do
    it 'returns result array without score field' do
      expect(presenter.results).to eq(scoreless_data)
    end
  end
end
