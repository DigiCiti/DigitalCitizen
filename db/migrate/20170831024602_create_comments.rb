class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :body, null: false
      t.references :user
      t.references :commentable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
