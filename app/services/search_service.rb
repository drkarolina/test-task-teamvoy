class SearchService
  def initialize(params, data)
    @data = data
    @query_words = QueryWordsService.new(params[:query].downcase)
  end

  # returns the result array of searched data
  def call
    result = data.map { |data_sample| search_data(data_sample) }.compact
    result.sort_by { |data_sample| -data_sample[:score] }
  end

  private

  attr_reader :data, :query_words

  def search_data(data_sample)
    string_data = data_sample.values.join(' ').downcase
    return if negative_search_fails?(string_data)
    return unless positive_search_passed?(string_data)

    add_calculated_score(data_sample)
  end

  # returns true if any word of negative search is found in data sample
  def negative_search_fails?(string_data)
    query_words.negative_search_words.any? { |word| string_data.include?(word) }
  end

  # returns true if all the words of positive search are found in data sample
  def positive_search_passed?(string_data)
    query_words.positive_search_words.all? { |word| string_data.include?(word) }
  end

  # adds relevance score to the data_sample hash
  def add_calculated_score(data_sample)
    score = ScoreCalculatorService.new(data_sample, query_words.positive_search_words).call
    data_sample.merge(score: score)
  end
end
