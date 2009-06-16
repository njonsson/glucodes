# Defines Importers::ConflictingRecordCountError.

module Importers; end

# An exception that occurs when a record count value referenced in a data file
# differs from the actual record count.
class Importers::ConflictingRecordCountError < RuntimeError
  
  # Instantiates a new Importers::ConflictingRecordCountError with the specified
  # _expected_ and _actual_ record counts.
  def initialize(expected, actual)
    super "#{expected} records were expected but there are #{actual} records"
  end
  
end
