class SearchService
  def initialize(params, data)
    @data = data
    @query_words = QueryWordsService.new(params[:query].downcase)
  end

  def call
    result = data.map { |data_sample| search_data(data_sample) }.compact
    result.sort_by { |data_sample| -data_sample[:score] }
  end

  private

  attr_reader :data, :query_words

  def search_data(data_sample)
    string_data = data_sample.values.join(' ').downcase
    return if negative_search_fails?(data_sample, string_data)
    return unless positive_search_passed?(data_sample, string_data)

    add_calculated_score(data_sample)
  end

  def negative_search_fails?(data_sample, string_data)
    query_words.negative_search.any? { |word| string_data.include?(word) } ||
      query_words.negative_exact_search.any? { |word| includes_word?(data_sample, word) }
  end

  def positive_search_passed?(data_sample, string_data)
    query_words.exact_search.all? { |word| includes_word?(data_sample, word) } &&
      query_words.positive_search.all? { |word| string_data.include?(word) }
  end

  def add_calculated_score(data_sample)
    score = ScoreCalculatorService.calculate(data_sample, query_words.positive_search)
    data_sample.merge(score: score)
  end

  def includes_word?(data_sample, word)
    data_sample.values.any? { |value| value.downcase.include?(word) }
  end
end
