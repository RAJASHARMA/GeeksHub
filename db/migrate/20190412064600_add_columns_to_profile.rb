class AddColumnsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :facebook, :string
    add_column :profiles, :twitter, :string
    add_column :profiles, :instagram, :string
    add_column :profiles, :linkedin, :string
    add_column :profiles, :youtube, :string
  end
end
