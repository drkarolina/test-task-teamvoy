require 'rails_helper'

RSpec.describe 'Search', type: :request do
  let(:data) do
    [{ NAME => 'A+',
       TYPE => 'Array',
       DESIGNED_BY => 'Arthur Whitney' },
     { NAME => 'ActionScript',
       TYPE => 'Compiled, Curly-bracket, Procedural, Reflective, Scripting, Object-oriented class-based',
       DESIGNED_BY => 'Gary Grossman' }]
  end
  let(:base_url) { '/' }

  describe 'GET /index' do
    context 'without params' do
      before do
        allow(SearchService).to receive(:new)
        allow(DataReaderService).to receive(:call).and_return(data)
        get base_url, params: {}
      end

      it 'does not call SearchService' do
        expect(SearchService).not_to have_received(:new)
      end

      it 'has 200 http status' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders all data' do
        expect(response.body).to include('Search Results (2)')
          .and include('A+')
          .and include('Array')
          .and include('Arthur Whitney')
          .and include('ActionScript')
          .and include('Compiled, Curly-bracket, Procedural, Reflective, Scripting, Object-oriented class-based')
          .and include('Gary Grossman')
      end
    end

    context 'with params' do
      before do
        allow(DataReaderService).to receive(:call).and_return(data)
        get base_url, params: { query: 'Compiled' }
      end

      it 'has 200 http status' do
        expect(response).to have_http_status(:ok)
      end

      it 'renders searched data' do
        expect(response.body).to include('Search Results (1)')
          .and include('ActionScript')
          .and include('Compiled, Curly-bracket, Procedural, Reflective, Scripting, Object-oriented class-based')
          .and include('Gary Grossman')
      end

      it 'does not render unsearched data' do
        expect(response.body).not_to include('A+')
      end
    end
  end
end
