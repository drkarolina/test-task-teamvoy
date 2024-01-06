require 'rails_helper'

RSpec.describe ResultsPresenter do
  let(:data) do
    [{ 'Name' => 'A+',
       'Type' => 'Array',
       'Designed by' => 'Arthur Whitney',
       score: 1 },
     { 'Name' => 'ActionScript',
       'Type' => 'Compiled, Curly-bracket, Procedural, Reflective, Scripting, Object-oriented class-based',
       'Designed by' => 'Gary Grossman',
       score: 0 }]
  end
  let(:scoreless_data) do
    [{ 'Name' => 'A+',
       'Type' => 'Array',
       'Designed by' => 'Arthur Whitney' },
     { 'Name' => 'ActionScript',
       'Type' => 'Compiled, Curly-bracket, Procedural, Reflective, Scripting, Object-oriented class-based',
       'Designed by' => 'Gary Grossman' }]
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
