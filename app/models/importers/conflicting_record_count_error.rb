module Importers; end

class Importers::ConflictingRecordCountError < RuntimeError
  
  def initialize(expected, actual)
    super "#{expected} records were expected but there are #{actual} records"
  end
  
end
