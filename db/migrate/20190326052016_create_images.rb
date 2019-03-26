class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :name
      t.integer :imageable_id
      t.string :imageable_type

      t.timestamps null: false
    end
  end
end
