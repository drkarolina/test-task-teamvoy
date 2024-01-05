class ResultsPresenter
  def initialize(results)
    @results = results
  end

  def results_count
    @results.count
  end

  def results
    @results.each { |hash| hash.delete(:score) }
  end
end
