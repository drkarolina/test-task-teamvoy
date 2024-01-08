class QueryWordsService
  def initialize(query)
    @query = query
  end

  # returns array of all the phrases and words for positive search
  def positive_search_words
    @positive_search_words ||= exact_search + positive_search
  end

  # returns array of all the phrases and words for negative search
  def negative_search_words
    @negative_search_words ||= negative_exact_search + negative_search
  end

  private

  attr_reader :query

  # returns array of all the phrases inside the quotation marks without - ("...")
  def exact_search
    @exact_search ||= query.scan(EXACT_SEARCH_QUERY_REGEX).flatten
  end

  # returns array of all the phrases inside the quotation marks with - (-"...")
  def negative_exact_search
    @negative_exact_search ||= query.scan(EXACT_NEGATIVE_SEARCH_QUERY_REGEX).flatten
  end

  # returns array of all the words outside the quotation marks without -
  def positive_search
    @positive_search ||= words_outside_quotes.scan(POSITIVE_SEARCH_QUERY_REGEX)
  end

  # returns array of all the words outside the quotation marks starting with -
  def negative_search
    @negative_search ||= words_outside_quotes.scan(NEGATIVE_SEARCH_QUERY_REGEX)
  end

  # returns string of all the words outside the quotation marks
  def words_outside_quotes
    @words_outside_quotes ||= (query.split('"') - exact_search - negative_exact_search).join(' ')
  end
end
