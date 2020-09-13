class CreateUserAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :user_addresses do |t|
      t.references :user, null: false, foreign_key: true, index: { unique: true }
      t.string :zipcode, null: false
      t.string :body, null: false

      t.timestamps
    end
  end
end
