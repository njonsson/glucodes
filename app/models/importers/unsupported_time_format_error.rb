# Defines Importers::UnsupportedTimeFormatError.

# Contains classes pertaining to external data file import.
module Importers; end

# An exception that occurs when an unrecognized time format appears in a data
# file.
class Importers::UnsupportedTimeFormatError < Importers::UnsupportedFormatError
  
  # Instantiates a new Importers::UnsupportedTimeFormatError with the specified
  # time data _format_.
  def initialize(format)
    super 'time', format
  end
  
end
