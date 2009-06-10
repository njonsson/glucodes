class CreateMeasurements < ActiveRecord::Migration
  def self.up
    create_table :measurements do |t|
      t.datetime :at,               :null => false
      t.boolean  :approximate_time, :null => false, :default => false
      t.date     :adjusted_date,    :null => false
      t.string   :time_period,      :null => false, :limit => 1
      t.integer  :value,            :null => false
      t.string   :notes
      t.timestamps
    end
  end

  def self.down
    drop_table :measurements
  end
end
