class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.references :user, null: false
      t.integer :friend_a, null: false
      t.integer :friend_b, null: false
      t.string :accepted, default: "unanswered" # can be "approved" or "rejected"

      t.timestamps
    end
  end
end
