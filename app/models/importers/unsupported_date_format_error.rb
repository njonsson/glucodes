# Defines Importers::UnsupportedDateFormatError.

module Importers; end

# An exception that occurs when an unrecognized date format appears in a data
# file.
class Importers::UnsupportedDateFormatError < Importers::UnsupportedFormatError
  
  # Instantiates a new Importers::UnsupportedDateFormatError with the specified
  # date data _format_.
  def initialize(format)
    super 'date', format
  end
  
end
