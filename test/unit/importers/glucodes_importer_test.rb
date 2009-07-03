require File.dirname(__FILE__) + '/../../test_helper'

module Importers; end

class Importers::GlucodesImporterTest < ActiveSupport::TestCase
  
  def setup
    @importer = Importers::GlucodesImporter.new
  end
  
  def add_header_to(content)
    content ||= ''
    header_and_content = <<-end_header_and_content
Date/Time,Approximate Time?,Value,Notes
#{content}
    end_header_and_content
    header_and_content.chomp
  end
  
  test 'should raise expected error when header is missing' do
    assert_no_difference 'Measurement.count' do
      assert_raise Importers::UnsupportedFileFormatError do
        @importer.import! <<-end_data
2009-07-02 22:39,FALSE,102,
2009-07-02 22:40,TRUE,92,
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
2009-07-02 22:39,FALSE,102,foo
2009-07-02 22:40,TRUE,92,bar
      end_data
      @importer.import! data
    end
    
    measurement1 = Measurement.all.first
    assert_equal Time.parse('2009-07-02 22:40 UTC'), measurement1.at
    assert_equal true,                               measurement1.approximate_time
    assert_equal 92,                                 measurement1.value
    assert_equal 'bar',                              measurement1.notes
    
    measurement2 = Measurement.all.last
    assert_equal Time.parse('2009-07-02 22:39 UTC'), measurement2.at
    assert_equal false,                              measurement2.approximate_time
    assert_equal 102,                                measurement2.value
    assert_equal 'foo',                              measurement2.notes
  end
  
  test 'should create expected measurements when importing two records from exported measurements' do
    measurements = []
    measurements << Measurement.new(:at => Time.parse('2009-07-02 22:39 UTC'),
                                    :approximate_time => false,
                                    :value => 102,
                                    :notes => 'foo')
    measurements << Measurement.new(:at => Time.parse('2009-07-02 22:40 UTC'),
                                    :approximate_time => true,
                                    :value => 92,
                                    :notes => 'bar')
    
    assert_difference 'Measurement.count', 2 do
      data = @importer.export(measurements)
      @importer.import! data
    end
    
    measurement1 = Measurement.all.first
    assert_equal Time.parse('2009-07-02 22:40 UTC'), measurement1.at
    assert_equal true,                               measurement1.approximate_time
    assert_equal 92,                                 measurement1.value
    assert_equal 'bar',                              measurement1.notes
    
    measurement2 = Measurement.all.last
    assert_equal Time.parse('2009-07-02 22:39 UTC'), measurement2.at
    assert_equal false,                              measurement2.approximate_time
    assert_equal 102,                                measurement2.value
    assert_equal 'foo',                              measurement2.notes
  end
  
end
