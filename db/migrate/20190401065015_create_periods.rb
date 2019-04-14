class CreatePeriods < ActiveRecord::Migration[5.2]
  def change
    create_table :periods do |t|
      t.boolean :is_active
      t.boolean :is_updated
      t.integer :duration
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
