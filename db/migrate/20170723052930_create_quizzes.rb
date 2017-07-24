class CreateQuizzes < ActiveRecord::Migration[5.1]
  def change
    create_table :quizzes do |t|
      t.string :question_1, null: false
      t.string :question_2, null: false
      t.string :question_3, null: false
      t.string :question_4, null: false
      t.string :question_5, null: false

      t.timestamps
    end
  end
end
