class AddIndexToProfiles < ActiveRecord::Migration
  def up
    execute %{
      CREATE INDEX
        profiles_lower_last_name
      ON
        profiles (lower(last_name) varchar_pattern_ops)
    }
    execute %{
      CREATE INDEX
        profiles_lower_first_name
      ON
        profiles (lower(first_name) varchar_pattern_ops)
    }
  end
  def down
    remove_index :profiles, name: 'profiles_lower_last_name'
    remove_index :profiles, name: 'profiles_lower_first_name'
  end
end
