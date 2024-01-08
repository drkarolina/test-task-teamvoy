# calculates relevance score based on name/type/designed by matches
class ScoreCalculatorService
  def initialize(data_sample, positive_search)
    @data_sample = data_sample
    @positive_search = positive_search
  end

  def call
    name_match_score + type_match_score + designed_by_match_score
  end

  private

  attr_reader :positive_search, :data_sample

  # returns 0 if no match, 3 if name matches partially and 6 if name matches compeletely
  def name_match_score
    return NO_MATCH_SCORE unless name_matches?
    return NAME_TOTAL_MATCH_SCORE if name_totally_matches?

    NAME_MATCH_SCORE
  end

  def type_match_score
    matches_counter(TYPE) * TYPE_MATCH_SCORE
  end

  def designed_by_match_score
    matches_counter(DESIGNED_BY) * DESIGNED_BY_MATCH_SCORE
  end

  def name_matches?
    data_sample[NAME].downcase.include? positive_search.join(' ')
  end

  def name_totally_matches?
    positive_search.join(' ').include? data_sample[NAME].downcase
  end

  def matches_counter(key)
    (positive_search & data_sample[key].downcase.split(', ')).count
  end
end
