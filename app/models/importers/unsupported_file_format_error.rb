# Defines Importers::UnsupportedFileFormatError.

module Importers; end

# An exception that occurs when unrecognized columns appear in a data file.
class Importers::UnsupportedFileFormatError < RuntimeError
  
  # Instantiates a new Importers::UnsupportedFileFormatError with the specified
  # import data file _column_names_.
  def initialize(column_names)
    quoted_column_names = column_names.collect do |c|
      "'#{c}'"
    end
    super "Unsupported file format has column headers " +
          quoted_column_names.to_sentence
  end
  
end
