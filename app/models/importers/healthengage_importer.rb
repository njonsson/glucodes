# Defines Importers::HealthengageImporter.

require 'csv'

module Importers; end

# Creates Measurement resources from the records in a data file exported from
# HealthEngage.net.
class Importers::HealthengageImporter
  
  # Create Measurement resources from the specified import file _data_. Creation
  # of model objects is done transactionally, so if an error occurs then no
  # objects are created.
  def import!(data)
    pointer        = 0
    header_checked = false
    
    Measurement.transaction do
      begin
        cells = []
        cells_count, pointer = CSV.parse_row(data, pointer, cells, ?;)
        unless header_checked
          raise_if_unsupported_header(cells)
          header_checked = true
          next
        end
        measurement = extract_measurement(cells)
        if measurement
          measurement.save! unless measurement == :not_a_measurement
        end
      end while cells_count > 0
    end
    
    self
  end
  
private
  
  def extract_measurement(cells)
    datetime_pattern = /^(\d{2,2})\/(\d{2,2})\/(\d{4,4}) (\d{2,2}):(\d{2,2}) (AM|PM)$/
    integer_pattern  = /^\d+$/
    return nil unless cells[0] =~ datetime_pattern
    return nil unless cells[1] =~ integer_pattern
    return nil unless cells[3] =~ integer_pattern
    return :not_a_measurement if cells[3] == '9'
    Measurement.new :at => cells[0].gsub(datetime_pattern, '\3-\1-\2 \4:\5 \6'),
                    :value => cells[1],
                    :notes => prepend_event_to_notes(cells[3], cells[7])
  end
  
  def prepend_event_to_notes(event_id, notes)
    event = case event_id
              when  '0' then nil
              when  '1' then 'Fasting'
              when  '2' then 'Before Exercise'
              when  '3' then 'After Exercise'
              when  '4' then 'Illness'
              when  '5' then 'Hypoglycemic'
              when  '6' then 'Hyperglycemic'
              when  '7' then 'Carb Intake'
              when  '8' then 'Insulin Dose'
              when '10' then 'Stress'
              when '11' then 'Oral Medication'
              when '12' then nil # A "See Notes" event
              else           "[HealthEngage event #{event_id}]"
            end
    if event
      return event unless notes
      return "#{event}: #{notes}"
    end
    notes
  end
  
  def raise_if_unsupported_header(cells)
    unless cells == %w(date mgValue mmolValue eventId dayPeriodId timePeriodId
                       enterTypeId comment)
      raise Importers::UnsupportedFileFormatError.new(cells)
    end
    self
  end
  
end
