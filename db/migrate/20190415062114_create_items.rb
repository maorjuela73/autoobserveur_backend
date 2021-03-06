class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :code
      t.string :function
      t.string :dimension
      t.string :name
      t.string :description
      t.boolean :is_active

      t.timestamps
    end
  end
end
