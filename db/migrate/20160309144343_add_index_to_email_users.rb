class AddIndexToEmailUsers < ActiveRecord::Migration
  def up
    execute %{
      CREATE INDEX
        users_lower_email
      ON
        users (lower(email) varchar_pattern_ops)
    }
  end
  def down
    remove_index :users, name: 'users_lower_email'
  end
end
