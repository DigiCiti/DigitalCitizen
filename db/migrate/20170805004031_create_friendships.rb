class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.references :user, null: false
      t.integer :friended_user, null: false
      t.string :status, default: "unanswered" # can be "approved" or "rejected"
      # consider codifcation of status to 0, 1, 2 or something lighter than strings

      t.timestamps
    end
  end
end
