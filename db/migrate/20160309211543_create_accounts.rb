class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :domain
      t.references :user, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
