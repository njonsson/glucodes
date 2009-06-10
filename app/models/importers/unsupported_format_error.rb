module Importers; end

class Importers::UnsupportedFormatError < RuntimeError
  
protected
  
  def initialize(format_name, format)
    super "Unsupported #{format_name} format '#{format}'"
  end
  
end
