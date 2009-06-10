module Importers; end

class Importers::UnsupportedTimeFormatError < Importers::UnsupportedFormatError
  
  def initialize(format)
    super 'time', format
  end
  
end
