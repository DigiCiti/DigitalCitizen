class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_digest
      t.string :f_name
      t.string :l_name
      t.string :city
      t.string :state
      t.string :country
      t.string :ideology
      t.string :party
      t.string :privacy_setting
      t.timestamps null: false
    end
  end
end
