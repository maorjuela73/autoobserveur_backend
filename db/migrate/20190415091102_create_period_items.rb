class CreatePeriodItems < ActiveRecord::Migration[5.2]
  def change
    create_table :period_items do |t|
      t.references :period, foreign_key: true
      t.references :item, foreign_key: true

      t.timestamps
    end
  end
end
