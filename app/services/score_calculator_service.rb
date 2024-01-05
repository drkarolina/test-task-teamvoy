class ScoreCalculatorService
  class << self
    def calculate(data_sample, positive_search)
      exact_matches_counter(positive_search, data_sample) * EXACT_MATCH_SCORE
    end

    private

    def exact_matches_counter(positive_search, data_sample)
      (positive_search & data_words(data_sample)).count
    end

    def data_words(data_sample)
      [
        data_sample['Name'],
        *data_sample['Type'].split(', '),
        *data_sample['Designed by'].split(', ')
      ].map(&:downcase)
    end
  end
end
