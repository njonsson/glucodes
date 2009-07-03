# Defines Importers::GlucodesImporter.

require 'csv'

module Importers; end

# Creates Measurement resources from the records in a data file exported from
# Glucodes.
class Importers::GlucodesImporter
  
  HEADER_CELLS = ['Date/Time', 'Approximate Time?', 'Value', 'Notes']
  
  def export(measurements)
    data = StringIO.new
    data.puts HEADER_CELLS.join(',')
    measurements.each do |m|
      cells = [m.at.to_s(:csv),
               m.approximate_time ? 'true' : 'false',
               m.value,
               m.notes.inspect]
      data.puts cells.join(',')
    end
    data.string
  end
  
  # Create Measurement resources from the specified import file _data_. Creation
  # of model objects is done transactionally, so if an error occurs then no
  # objects are created.
  def import!(data)
    pointer        = 0
    header_checked = false
    
    Measurement.transaction do
      begin
        cells = []
        cells_count, pointer = CSV.parse_row(data, pointer, cells)
        unless header_checked
          raise_if_unsupported_header(cells)
          header_checked = true
          next
        end
        measurement = extract_measurement(cells)
        measurement.save! if measurement
      end while cells_count > 0
    end
    
    self
  end
  
private
  
  def extract_measurement(cells)
    datetime_pattern = /^(\d{4,4})-(\d{2,2})-(\d{2,2}) (\d{2,2}):(\d{2,2})$/
    boolean_pattern  = /^(true|false)$/i
    numeric_pattern  = /^\d+(\.\d+)?$/
    return nil unless cells[0] =~ datetime_pattern
    return nil unless cells[1] =~ boolean_pattern
    return nil unless cells[2] =~ numeric_pattern
    Measurement.new :at => cells[0],
                    :approximate_time => cells[1],
                    :value => cells[2],
                    :notes => cells[3]
  end
  
  def raise_if_unsupported_header(cells)
    unless cells == HEADER_CELLS
      raise Importers::UnsupportedFileFormatError.new(cells)
    end
    self
  end
  
end
