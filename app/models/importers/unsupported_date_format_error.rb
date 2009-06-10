module Importers; end

class Importers::UnsupportedDateFormatError < Importers::UnsupportedFormatError
  
  def initialize(format)
    super 'date', format
  end
  
end
