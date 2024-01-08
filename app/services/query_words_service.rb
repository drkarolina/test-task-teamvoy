class QueryWordsService
  def initialize(query)
    @query = query
  end

  def positive_search_words
    @positive_search_words ||= exact_search + positive_search
  end

  def negative_search_words
    @negative_search_words ||= negative_exact_search + negative_search
  end

  private

  attr_reader :query

  def exact_search
    @exact_search ||= query.scan(EXACT_SEARCH_QUERY_REGEX).flatten
  end

  def negative_exact_search
    @negative_exact_search ||= query.scan(EXACT_NEGATIVE_SEARCH_QUERY_REGEX).flatten
  end

  def positive_search
    @positive_search ||= words_outside_quotes.scan(POSITIVE_SEARCH_QUERY_REGEX)
  end

  def negative_search
    @negative_search ||= words_outside_quotes.scan(NEGATIVE_SEARCH_QUERY_REGEX)
  end

  def words_outside_quotes
    @words_outside_quotes ||= (query.split('"') - exact_search - negative_exact_search).join(' ')
  end
end
