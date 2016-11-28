class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name,            null: false, default: ""
      t.string :email,           null: false, default: ""
      t.string :auth_token,      null: false, default: ""
      t.string :password_digest, null: false, default: ""

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :auth_token, unique: true
  end
end
