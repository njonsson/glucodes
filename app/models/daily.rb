# Defines Daily.

# Represents a set of daily aggregate Measurement statistics.
class Daily < Aggregate
  
  # Returns the default page size for Daily.paginate results.
  def self.per_page
    25
  end
  
end
