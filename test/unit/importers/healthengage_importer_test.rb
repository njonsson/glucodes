require File.dirname(__FILE__) + '/../../test_helper'

module Importers; end

class Importers::HealthengageImporterTest < ActiveSupport::TestCase
  
  def setup
    @importer = Importers::HealthengageImporter.new
  end
  
  def add_header_to(content)
    content ||= ''
    header_and_content = <<-end_header_and_content
date;mgValue;mmolValue;eventId;dayPeriodId;timePeriodId;enterTypeId;comment
#{content}
    end_header_and_content
    header_and_content.chomp
  end
  
  test 'should raise expected error when header is missing' do
    assert_no_difference 'Measurement.count' do
      assert_raise Importers::UnsupportedFileFormatError do
        @importer.import! <<-end_data
04/02/2009 01:29 PM;102;5.66;0;2;0;24;
04/02/2009 09:29 AM;92;5.11;0;1;2;24;
        end_data
      end
    end
  end
  
  test 'should not create measurements when importing zero records' do
    assert_no_difference 'Measurement.count' do
      @importer.import! add_header_to(nil)
    end
  end
  
  test 'should create expected measurements when importing two records' do
    assert_difference 'Measurement.count', 2 do
      data = add_header_to <<-end_data
04/02/2009 01:29 PM;102;5.66;0;2;0;24;foo
04/02/2009 09:29 AM;92;5.11;0;1;2;24;bar
      end_data
      @importer.import! data
    end
    
    measurement1 = Measurement.all.first
    assert_equal Time.parse('2009-04-02 13:29 UTC'), measurement1.at
    assert_equal 102,                                measurement1.value
    assert_equal 'foo',                              measurement1.notes
    
    measurement2 = Measurement.all.last
    assert_equal Time.parse('2009-04-02 09:29 UTC'), measurement2.at
    assert_equal 92,                                 measurement2.value
    assert_equal 'bar',                              measurement2.notes
  end
  
  test 'should import measurement from record marked "Fasting"' do
    assert_difference 'Measurement.count' do
      data = add_header_to <<-end_data
06/13/2009 09:40 PM;101;5.61;1;6;0;0;foo
      end_data
      @importer.import! data
    end
    
    measurement1 = Measurement.all.first
    assert_equal Time.parse('2009-06-13 21:40 UTC'), measurement1.at
    assert_equal 101,                                measurement1.value
    assert_equal 'Fasting: foo',                     measurement1.notes
  end
  
  test 'should import measurement from record marked "Before Exercise"' do
    assert_difference 'Measurement.count' do
      data = add_header_to <<-end_data
06/13/2009 09:35 PM;150;8.33;2;6;0;0;
      end_data
      @importer.import! data
    end
    
    measurement1 = Measurement.all.first
    assert_equal Time.parse('2009-06-13 21:35 UTC'), measurement1.at
    assert_equal 150,                                measurement1.value
    assert_equal 'Before Exercise',                  measurement1.notes
  end
  
  test 'should import measurement from record marked "After Exercise"' do
    assert_difference 'Measurement.count' do
      data = add_header_to <<-end_data
06/13/2009 09:45 PM;134;7.44;3;6;0;0;foo
      end_data
      @importer.import! data
    end
    
    measurement1 = Measurement.all.first
    assert_equal Time.parse('2009-06-13 21:45 UTC'), measurement1.at
    assert_equal 134,                                measurement1.value
    assert_equal 'After Exercise: foo',              measurement1.notes
  end
  
  test 'should import measurement from record marked "Illness"' do
    assert_difference 'Measurement.count' do
      data = add_header_to <<-end_data
06/13/2009 09:50 PM;124;6.88;4;6;0;0;
      end_data
      @importer.import! data
    end
    
    measurement1 = Measurement.all.first
    assert_equal Time.parse('2009-06-13 21:50 UTC'), measurement1.at
    assert_equal 124,                                measurement1.value
    assert_equal 'Illness',                          measurement1.notes
  end
  
  test 'should import measurement from record marked "Hypoglycemic"' do
    assert_difference 'Measurement.count' do
      data = add_header_to <<-end_data
06/13/2009 09:55 PM;50;0.0;5;6;0;0;foo
      end_data
      @importer.import! data
    end
    
    measurement1 = Measurement.all.first
    assert_equal Time.parse('2009-06-13 21:55 UTC'), measurement1.at
    assert_equal 50,                                 measurement1.value
    assert_equal 'Hypoglycemic: foo',                measurement1.notes
  end
  
  test 'should import measurement from record marked "Hyperglycemic"' do
    assert_difference 'Measurement.count' do
      data = add_header_to <<-end_data
06/13/2009 10:00 PM;112;6.22;6;6;0;0;
      end_data
      @importer.import! data
    end
    
    measurement1 = Measurement.all.first
    assert_equal Time.parse('2009-06-13 22:00 UTC'), measurement1.at
    assert_equal 112,                                measurement1.value
    assert_equal 'Hyperglycemic',                    measurement1.notes
  end
  
  test 'should import measurement from record marked "Carb Intake"' do
    assert_difference 'Measurement.count' do
      data = add_header_to <<-end_data
06/13/2009 10:05 PM;111;6.16;7;6;0;0;foo
      end_data
      @importer.import! data
    end
    
    measurement1 = Measurement.all.first
    assert_equal Time.parse('2009-06-13 22:05 UTC'), measurement1.at
    assert_equal 111,                                measurement1.value
    assert_equal 'Carb Intake: foo',                 measurement1.notes
  end
  
  test 'should import measurement from record marked "Insulin Dose"' do
    assert_difference 'Measurement.count' do
      data = add_header_to <<-end_data
06/13/2009 10:10 PM;222;12.32;8;6;0;0;
      end_data
      @importer.import! data
    end
    
    measurement1 = Measurement.all.first
    assert_equal Time.parse('2009-06-13 22:10 UTC'), measurement1.at
    assert_equal 222,                                measurement1.value
    assert_equal 'Insulin Dose',                     measurement1.notes
  end
  
  test 'should not import measurement from record marked "Invalid Test"' do
    assert_no_difference 'Measurement.count' do
      data = add_header_to <<-end_data
06/13/2009 10:15 PM;98;5.44;9;6;0;0;foo
      end_data
      @importer.import! data
    end
  end
  
  test 'should import measurement from record marked "Stress"' do
    assert_difference 'Measurement.count' do
      data = add_header_to <<-end_data
06/13/2009 10:20 PM;97;5.38;10;6;0;0;
      end_data
      @importer.import! data
    end
    
    measurement1 = Measurement.all.first
    assert_equal Time.parse('2009-06-13 22:20 UTC'), measurement1.at
    assert_equal 97,                                 measurement1.value
    assert_equal 'Stress',                           measurement1.notes
  end
  
  test 'should import measurement from record marked "Oral Medication"' do
    assert_difference 'Measurement.count' do
      data = add_header_to <<-end_data
06/13/2009 10:25 PM;87;4.83;11;6;0;0;foo
      end_data
      @importer.import! data
    end
    
    measurement1 = Measurement.all.first
    assert_equal Time.parse('2009-06-13 22:25 UTC'), measurement1.at
    assert_equal 87,                                 measurement1.value
    assert_equal 'Oral Medication: foo',             measurement1.notes
  end
  
  test 'should import measurement from record marked "See Notes"' do
    assert_difference 'Measurement.count' do
      data = add_header_to <<-end_data
06/13/2009 10:30 PM;56;3.11;12;6;0;0;foo
      end_data
      @importer.import! data
    end
    
    measurement1 = Measurement.all.first
    assert_equal Time.parse('2009-06-13 22:30 UTC'), measurement1.at
    assert_equal 56,                                 measurement1.value
    assert_equal 'foo',                              measurement1.notes
  end
  
end
