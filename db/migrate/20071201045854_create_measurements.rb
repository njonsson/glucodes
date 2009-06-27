class CreateMeasurements < ActiveRecord::Migration
  def self.up
    create_table :measurements do |t|
      t.datetime :at,               :null => false
      t.boolean  :approximate_time, :null => false, :default => false
      t.date     :adjusted_date,    :null => false
      t.string   :time_slot,        :null => false, :limit => 1
      t.float    :value,            :null => false
      t.float    :skew,             :null => false
      t.string   :notes
      t.timestamps
    end

    add_index :measurements, :at
    add_index :measurements, :adjusted_date
    add_index :measurements, :time_slot
  end

  def self.down
    drop_table :measurements
  end
end
