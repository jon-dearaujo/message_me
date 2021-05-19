class CreateUsersAndMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.timestamps
    end

    create_table :messages do |t|
      t.text :body
      t.integer :user_id
      t.timestamps
    end
  end
end
