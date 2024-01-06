require 'json'

class DataReaderService
  def self.call
    file = File.read(JSON_FILE_PATH)
    JSON.parse(file)
  end
end
