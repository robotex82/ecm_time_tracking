class CreateEcmTimeTrackingEntries < ActiveRecord::Migration
  def change
    create_table :ecm_time_tracking_entries do |t|
      t.integer :tracker_id
      t.timestamp :begin_at
      t.timestamp :end_at
      t.integer :break_length_in_seconds
      t.text :description

      t.timestamps null: false
    end
  end
end
