class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.timestamps
      
      t.string :name
      t.text :introduction
      t.integer :price
      t.boolean :is_active, default: true
    end
  end
end
