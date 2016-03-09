class AddIndexToAccounts < ActiveRecord::Migration
  def up
    execute %{
      CREATE INDEX
        accounts_lower_domain
      ON
        accounts (lower(domain) varchar_pattern_ops)
    }
    execute %{
      CREATE INDEX
        accounts_lower_name
      ON
        accounts (lower(name) varchar_pattern_ops)
    }
  end
  def down
    remove_index :accounts, name: 'accounts_lower_domain'
    remove_index :accounts, name: 'accounts_lower_name'
  end
end
