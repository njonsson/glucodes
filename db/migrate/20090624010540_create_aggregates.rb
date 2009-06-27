class CreateAggregates < ActiveRecord::Migration
  def self.up
    create_table :aggregates do |t|
      t.string  :type,                         :null => false
      t.date    :period_ends_on,               :null => false
      t.boolean :contains_approximate_times,   :null => false, :default => false
      t.float   :average_value,                :null => false
      t.float   :standard_deviation_of_value,  :null => false
      t.float   :maximum_value,                :null => false
      t.float   :minimum_value,                :null => false
      t.float   :average_skew,                 :null => false
      t.float   :average_value_in_time_slot_a
      t.float   :average_value_in_time_slot_b
      t.float   :average_value_in_time_slot_c
      t.float   :average_value_in_time_slot_d
      t.float   :average_value_in_time_slot_e
      t.float   :average_value_in_time_slot_f
      t.float   :average_skew_in_time_slot_a
      t.float   :average_skew_in_time_slot_b
      t.float   :average_skew_in_time_slot_c
      t.float   :average_skew_in_time_slot_d
      t.float   :average_skew_in_time_slot_e
      t.float   :average_skew_in_time_slot_f
      t.string  :notes
      t.timestamps
    end

    add_index :aggregates, :type
    add_index :aggregates, :period_ends_on
  end

  def self.down
    drop_table :aggregates
  end
end
