class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :public_email
      t.string :location
      t.string :country
      t.string :profession
      t.string :organization
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
