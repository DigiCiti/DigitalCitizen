class CreateEntries < ActiveRecord::Migration[5.1]
  def change
    create_table :entries do |t|
      t.string :title
      t.text :body, null: false
      # consider codifying entry_type into integers by having another table
      t.string :entry_type, null: false # "profile_post", "memo", "group_page"...
      t.references :user
      t.timestamps
    end
  end
end
