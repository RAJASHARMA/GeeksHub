class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.text :description
      t.references :article, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
