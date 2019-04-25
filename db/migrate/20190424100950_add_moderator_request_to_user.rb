class AddModeratorRequestToUser < ActiveRecord::Migration
  def change
    add_column :users, :moderator_request, :boolean
  end
end
