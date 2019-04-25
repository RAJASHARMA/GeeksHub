class AddTimestampsToReport < ActiveRecord::Migration
  def change
    add_column :reports, :created_at, :datetime
    add_column :reports, :updated_at, :datetime
  end
end
