class CreateResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :responses do |t|
      # t.integer :quiz_id, null: false
      # t.integer :user_id, null: false
      t.integer :left, default: 0
      t.integer :right, default: 0
      t.integer :political_stance, default: 0
      t.string :response_1
      t.string :response_2
      t.string :response_3
      t.string :response_4
      t.string :response_5
      t.string :quiz_result
      t.belongs_to :quiz, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
