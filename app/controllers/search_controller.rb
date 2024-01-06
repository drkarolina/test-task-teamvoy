class SearchController < ApplicationController
  before_action :results_presenter, only: %i[index search]

  def index; end

  def search
    update_search_results_partial
  end

  private

  def results_presenter
    @results_presenter ||= ResultsPresenter.new(search_rusults)
  end

  def search_rusults
    return data if search_params[:query].blank?

    SearchService.new(search_params, data).call
  end

  def data
    @data ||= DataReaderService.call
  end

  def update_search_results_partial
    render turbo_stream:
      turbo_stream.replace('results',
                           partial: 'search/search_results',
                           locals: { results: results_presenter.results, counter: results_presenter.results_count })
  end

  def search_params
    params.permit(:query)
  end
end
