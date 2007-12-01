class CreateMeasurements < ActiveRecord::Migration
  def self.up
    create_table :measurements do |t|
      t.date    :accounting_date
      t.string  :accounting_time_period, :limit => 1
      t.integer :value, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :measurements
  end
end
