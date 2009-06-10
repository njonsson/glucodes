require 'csv'

module Importers; end

class Importers::LifescanUltrasmartImporter
  
  DATE_FORMAT_PATTERN        = /^Date Format : (.+)$/
  MEASUREMENTS_COUNT_PATTERN = /^Total Number of Readings in Data File: (\d+)$/
  TIME_FORMAT_PATTERN        = /^Time Format : (.+)$/
  
  def import!(data)
    pointer             = 0
    date_format_checked = false
    time_format_checked = false
    record_count        = nil
    actual_record_count = 0
    
    Measurement.transaction do
      begin
        cells = []
        cells_count, pointer = CSV.parse_row(data, pointer, cells)
        unless date_format_checked
          date_format_checked = raise_if_unsupported_date_format(cells.first)
          next
        end
        unless time_format_checked
          time_format_checked = raise_if_unsupported_time_format(cells.first)
          next
        end
        unless record_count
          record_count = extract_measurements_count(cells.first) 
          next
        end
        measurement = extract_measurement(cells)
        if measurement
          measurement.save! unless measurement == :not_a_measurement
          actual_record_count += 1
        end
      end while cells_count > 0
      
      if record_count || (actual_record_count > 0)
        unless record_count == actual_record_count
          raise Importers::ConflictingRecordCountError.new(record_count,
                                                           actual_record_count)
        end
      end
    end
    
    self
  end
  
private
  
  def extract_measurement(cells)
    integer_pattern = /^(\d+)$/
    date_pattern    = /^(\d{2,2})\/(\d{2,2})\/(\d{4,4})$/
    time_pattern    = /^(\d{2,2}):(\d{2,2}):(\d{2,2})$/
    return nil unless cells[0] =~ integer_pattern
    return nil unless cells[1] =~ date_pattern
    return nil unless cells[2] =~ time_pattern
    return nil unless cells[3] =~ integer_pattern
    return :not_a_measurement unless cells[5] =~ integer_pattern
    return :not_a_measurement unless cells[6] == '10'
    Measurement.new :at => cells[1].gsub(date_pattern, '\3-\1-\2') + ' ' +
                           cells[2].gsub(time_pattern, '\1:\2:\3'),
                    :value => cells[3].gsub(integer_pattern, '\1')
  end
  
  def extract_measurements_count(cell)
    if cell =~ MEASUREMENTS_COUNT_PATTERN
      return cell.gsub(MEASUREMENTS_COUNT_PATTERN, '\1').to_i
    end
    nil
  end
  
  def raise_if_unsupported_date_format(cell)
    raise_if_unsupported_format cell, :format_pattern => DATE_FORMAT_PATTERN,
                                      :supported_format => 'M.D.Y',
                                      :error_class => Importers::UnsupportedDateFormatError,
                                      :format_name => 'date'
  end
  
  def raise_if_unsupported_format(cell, options={})
    return false unless cell =~ options[:format_pattern]
    format = cell.gsub(options[:format_pattern], '\1')
    unless format == options[:supported_format]
      raise options[:error_class].new(format)
    end
    true
  end
  
  def raise_if_unsupported_time_format(cell)
    raise_if_unsupported_format cell, :format_pattern => TIME_FORMAT_PATTERN,
                                      :supported_format => '24:00',
                                      :error_class => Importers::UnsupportedTimeFormatError,
                                      :format_name => 'time'
  end
  
end
