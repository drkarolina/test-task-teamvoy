class SearchService
  def initialize(params, data)
    @data = data
    parse_query(params[:query].downcase)
  end

  def call
    result = data.map { |data_sample| search_data(data_sample) }.compact
    result.sort_by { |data_sample| -data_sample[:score] }
  end

  private

  attr_reader :data, :negative_search, :positive_search, :exact_search, :negative_exact_search

  def parse_query(query)
    @positive_search = parse_positive_search(query)
    @negative_search = parse_negative_search(query)
    @exact_search = parse_exact_search(query)
    @negative_exact_search = parse_negative_exact_search(query)
  end

  def parse_positive_search(query)
    query.scan(POSITIVE_SEARCH_QUERY_REGEX)
  end

  def parse_negative_search(query)
    query.scan(NEGATIVE_SEARCH_QUERY_REGEX)
  end

  def parse_exact_search(query)
    query.scan(EXACT_SEARCH_QUERY_REGEX).flatten
  end

  def parse_negative_exact_search(query)
    query.scan(EXACT_NEGATIVE_SEARCH_QUERY_REGEX).flatten
  end

  def search_data(data_sample)
    string_data = data_sample.values.join(', ').downcase
    return if negative_search_fails?(data_sample, string_data)
    return unless positive_search_passed?(data_sample, string_data)

    calculate_score(data_sample, string_data)
  end

  def negative_search_fails?(data_sample, string_data)
    negative_search.any? { |word| string_data.include?(word) } ||
      negative_exact_search.any? { |word| includes_word?(data_sample, word) }
  end

  def positive_search_passed?(data_sample, string_data)
    exact_search.all? { |word| includes_word?(data_sample, word) } &&
      positive_search.all? { |word| string_data.include?(word) }
  end

  def calculate_score(data_sample, string_data)
    score_counter = (positive_search & string_data.split(', ')).count
    data_sample.merge(score: score_counter * EXACT_MATCH_SCORE)
  end

  def includes_word?(data_sample, word)
    data_sample.values.any? { |value| value.downcase.include?(word) }
  end
end
