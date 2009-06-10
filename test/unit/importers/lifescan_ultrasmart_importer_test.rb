require File.dirname(__FILE__) + '/../../test_helper'

module Importers; end

class Importers::LifescanUltrasmartImporterTest < ActiveSupport::TestCase
  
  def setup
    @importer = Importers::LifescanUltrasmartImporter.new
  end
  
  def add_header_to(content)
    content ||= ''
    header_and_content = <<-end_header_and_content
"OneTouch (R) Diabetes Management Software v2.3.2 P1/V2.3.2 01.23.08"
"1033 , 1033"
"mg/dL"
"Date Format : M.D.Y"
"Time Format : 24:00"
"Total Number of Readings in Data File: #{content.split(/[\r\n]+/).length}"
"Patient Name: Guest, Guest "
#{content}
    end_header_and_content
    header_and_content.chomp
  end
  
  test 'should not create measurements when the header is missing' do
    assert_no_difference 'Measurement.count' do
      @importer.import <<-end_data
"1829","06/08/2009","20:31:00","343","RGQ85C6BV","2","10","-1","0","6","","7","3","","","1","0"
"1828","06/08/2009","12:30:00","160","RGQ85C6BV","2","10","-1","0","3","","7","3","","","2","0"
      end_data
    end
  end
  
  test 'should raise expected error if date format is unsupported' do
    assert_raise Importers::UnsupportedDateFormatError do
      @importer.import <<-end_data
"OneTouch (R) Diabetes Management Software v2.3.2 P1/V2.3.2 01.23.08"
"1033 , 1033"
"mg/dL"
"Date Format : BOGUS_DATE_FORMAT"
      end_data
    end
  end
  
  test 'should raise expected error if time format is unsupported' do
    assert_raise Importers::UnsupportedTimeFormatError do
      @importer.import <<-end_data
"OneTouch (R) Diabetes Management Software v2.3.2 P1/V2.3.2 01.23.08"
"1033 , 1033"
"mg/dL"
"Date Format : M.D.Y"
"Time Format : BOGUS_TIME_FORMAT"
      end_data
    end
  end
  
  test "should raise expected error and not create measurements when record count is incorrect" do
    assert_no_difference 'Measurement.count' do
      assert_raise Importers::ConflictingRecordCountError do
        @importer.import <<-end_data
"OneTouch (R) Diabetes Management Software v2.3.2 P1/V2.3.2 01.23.08"
"1033 , 1033"
"mg/dL"
"Date Format : M.D.Y"
"Time Format : 24:00"
"Total Number of Readings in Data File: 3"
"Patient Name: Guest, Guest "
        end_data
      end
    end
  end
  
  test 'should not create measurements when importing zero records' do
    assert_no_difference 'Measurement.count' do
      @importer.import add_header_to(nil)
    end
  end
  
  test 'should create expected measurements when importing two records' do
    assert_difference 'Measurement.count', 2 do
      data = add_header_to <<-end_data
"1829","06/08/2009","20:31:00","343","RGQ85C6BV","2","10","-1","0","6","","7","3","","","1","0"
"1828","06/08/2009","12:30:00","160","RGQ85C6BV","2","10","-1","0","3","","7","3","","","2","0"
      end_data
      @importer.import data
    end
    
    measurement1 = Measurement.all.first
    assert_equal Time.parse('2009-06-08 20:31 UTC'), measurement1.at
    assert_equal 343,                                measurement1.value
    
    measurement2 = Measurement.all.last
    assert_equal Time.parse('2009-06-08 12:30 UTC'), measurement2.at
    assert_equal 160,                                measurement2.value
  end
  
  test 'should only create valid measurements when importing four records' do
    assert_difference 'Measurement.count' do
      data = add_header_to <<-end_data
"1829","06/08/2009","20:31:00","343","RGQ85C6BV","","10","-1","0","6","","7","3","","","1","0"
"1828","06/08/2009","12:30:00","160","RGQ85C6BV","2","30","-1","0","3","","7","3","","","2","0"
"1827","06/08/2009","10:07:00","263","RGQ85C6BV","","30","-1","0","2","","7","3","","","3","0"
"1826","06/08/2009","07:22:00","66","RGQ85C6BV","2","10","-1","0","1","","7","3","","","4","0"
      end_data
      @importer.import data
    end
    
    measurement1 = Measurement.all.first
    assert_equal Time.parse('2009-06-08 07:22 UTC'), measurement1.at
    assert_equal 66,                                 measurement1.value
  end
  
end
