class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|
      t.references :period_item, foreign_key: true
      t.integer :value
      t.text :comment

      t.timestamps
    end
  end
end
