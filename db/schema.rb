# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090624010540) do

  create_table "aggregates", :force => true do |t|
    t.string   "type",                                            :null => false
    t.date     "period_ends_on",                                  :null => false
    t.boolean  "contains_approximate_times",   :default => false, :null => false
    t.float    "average_value",                                   :null => false
    t.float    "standard_deviation_of_value",                     :null => false
    t.float    "maximum_value",                                   :null => false
    t.float    "minimum_value",                                   :null => false
    t.float    "average_skew",                                    :null => false
    t.float    "average_value_in_time_slot_a"
    t.float    "average_value_in_time_slot_b"
    t.float    "average_value_in_time_slot_c"
    t.float    "average_value_in_time_slot_d"
    t.float    "average_value_in_time_slot_e"
    t.float    "average_value_in_time_slot_f"
    t.float    "average_skew_in_time_slot_a"
    t.float    "average_skew_in_time_slot_b"
    t.float    "average_skew_in_time_slot_c"
    t.float    "average_skew_in_time_slot_d"
    t.float    "average_skew_in_time_slot_e"
    t.float    "average_skew_in_time_slot_f"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "aggregates", ["period_ends_on"], :name => "index_aggregates_on_period_ends_on"
  add_index "aggregates", ["type"], :name => "index_aggregates_on_type"

  create_table "measurements", :force => true do |t|
    t.datetime "at",                                               :null => false
    t.boolean  "approximate_time",              :default => false, :null => false
    t.date     "adjusted_date",                                    :null => false
    t.string   "time_slot",        :limit => 1,                    :null => false
    t.float    "value",                                            :null => false
    t.float    "skew",                                             :null => false
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "measurements", ["adjusted_date"], :name => "index_measurements_on_adjusted_date"
  add_index "measurements", ["at"], :name => "index_measurements_on_at"
  add_index "measurements", ["time_slot"], :name => "index_measurements_on_time_slot"

end
