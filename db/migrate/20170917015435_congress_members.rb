class ProPublicaCongressAdapters < ActiveRecord::Migration[5.1]
  def change
    create_table :congress_members do |t|
      t.string :f_name, null: false
      t.string :l_name, null: false
      t.string :politician_id, null: false
    end
  end
end
