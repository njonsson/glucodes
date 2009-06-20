# Defines MeasurementsController.

# Handles requests for Measurement resources.
class MeasurementsController < ApplicationController
  
  def index
    @measurements = Measurement.paginate(options_for_paginate)
    
    respond_to do |format|
      format.html # index.html.haml
    end
  end
  
private
  
  def options_for_paginate
    options = HashWithIndifferentAccess.new(:page => 1, :per_page => 20)
    options.merge(params.slice(:page, :per_page)).symbolize_keys
  end
  
end
