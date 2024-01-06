require 'rails_helper'

RSpec.describe SearchService do
  let(:data) { DataReaderService.call }
  let(:result) { described_class.new(params, data).call }

  before do
    stub_const('JSON_FILE_PATH', 'spec/data/seacrh_test_data.json')
  end

  describe '#call' do
    context 'with reordered words' do
      let(:params) { { query: 'Lisp Common' } }
      let(:expected_result) { 'Common Lisp' }

      it 'returns an array with 1 match' do
        expect(result.count).to eq(1)
      end

      it 'matches a programming language named Common Lisp' do
        expect(result.first['Name']).to eq('Common Lisp')
      end
    end

    context 'with exact search words' do
      let(:params) { { query: 'Interpreted "Thomas Eugene"' } }
      let(:expected_result) { 'BASIC' }

      it 'returns an array with 1 match' do
        expect(result.count).to eq(1)
      end

      it 'matches a programming language named BASIC and not Haskell' do
        expect(result.first['Name']).to eq('BASIC')
      end
    end

    context 'with search in different fields' do
      let(:params) { { query: 'Scripting Microsoft' } }
      let(:expected_result) { ['JScript', 'VBScript', 'Windows PowerShell'] }

      it 'returns an array with 3 matches' do
        expect(result.count).to eq(3)
      end

      it 'matches a programming languages named JScript, VBScript, Windows, PowerShell and not C#' do
        found_results = result.map { |hash| hash['Name'] }
        expect(found_results).to eq(expected_result)
      end
    end

    context 'with negative searches' do
      let(:params) { { query: 'john -array' } }
      let(:expected_result) { %w[BASIC Haskell Lisp S-Lang] }

      it 'returns an array with 4 matches' do
        expect(result.count).to eq(4)
      end

      it 'matches a programming languages "BASIC", "Haskell", "Lisp" and "S-Lang"' do
        found_results = result.map { |hash| hash['Name'] }
        expect(found_results).to eq(expected_result)
      end
    end

    context 'with no results' do
      let(:params) { { query: 'AAAAAAAAAAAAAAAAAAAAAAAAAA' } }

      it 'returns an array with 0 matches' do
        expect(result.count).to eq(0)
      end
    end
  end
end
