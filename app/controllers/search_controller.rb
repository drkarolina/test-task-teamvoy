class SearchController < ApplicationController
  def index
    @results_presenter = ResultsPresenter.new(search_rusults)
  end

  private

  def search_rusults
    return data if search_params[:query].blank?

    SearchService.new(search_params, data).call
  end

  def data
    @data ||= DataReaderService.call
  end

  def search_params
    params.permit(:query)
  end
end
