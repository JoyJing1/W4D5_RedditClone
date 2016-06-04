class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :author_id, null: false
      t.integer :post_id, null: false

      t.timestamps null: false
      t.index :author_id
      t.index :post_id
    end
  end
end
