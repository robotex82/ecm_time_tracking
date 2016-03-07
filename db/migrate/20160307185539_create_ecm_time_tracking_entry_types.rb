class CreateEcmTimeTrackingEntryTypes < ActiveRecord::Migration
  def change
    create_table :ecm_time_tracking_entry_types do |t|
      t.string :identifier
      t.integer :due_in_seconds

      t.timestamps null: false
    end
  end
end
