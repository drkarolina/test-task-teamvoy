class SearchController < ApplicationController
  def index
    @results = data
  end

  private

  def data
    return if search_params[:query].present?

    DataReaderService.call
  end

  def search_params
    params.permit(:query)
  end
end
