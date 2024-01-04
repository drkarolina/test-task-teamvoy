require 'json'

class DataReaderService
  def self.call
    file = File.read('db/data.json')
    JSON.parse(file)
  end
end
