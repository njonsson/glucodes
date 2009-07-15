# Defines MeasurementsController.

# Handles requests for Measurement resources.
class MeasurementsController < ApplicationController
  
  # Handles requests:
  # * GET /measurements/index
  # * GET /measurements/index.xml
  def index
    @measurements = Measurement.paginate(options_for_paginate)
    
    if request.xhr?
      render :partial => 'measurements', :object => @measurements
      return
    end
    
    respond_to do |format|
      format.html # index.html.haml
    end
  end
  
  # Handles requests:
  # * GET /measurements/summary-by-day
  # * GET /measurements/summary-by-day.xml
  def summary_by_day
    @dailies = Daily.paginate(options_for_paginate)
    
    if request.xhr?
      render :partial => 'dailies', :object => @dailies
      return
    end
    
    respond_to do |format|
      format.html # summary_by_day.html.haml
    end
  end
  
private
  
  def options_for_paginate
    options = HashWithIndifferentAccess.new(:page => 1)
    options.merge(params.slice(:page, :per_page)).symbolize_keys
  end
  
end
