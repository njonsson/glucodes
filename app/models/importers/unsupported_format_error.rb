module Importers; end

class Importers::UnsupportedFormatError < RuntimeError # :nodoc:
  
protected
  
  def initialize(format_name, format)
    super "Unsupported #{format_name} format '#{format}'"
  end
  
end
