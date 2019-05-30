class CreateAdvices < ActiveRecord::Migration[5.2]
  def change
    create_table :advices do |t|
      t.references :item, foreign_key: true
      t.string :level
      t.string :advice

      t.timestamps
    end
  end
end
