module Importers; end

class Importers::UnsupportedFileFormatError < RuntimeError
  
  def initialize(column_names)
    quoted_column_names = column_names.collect do |c|
      "'#{c}'"
    end
    super "Unsupported file format has column headers " +
          quoted_column_names.to_sentence
  end
  
end
