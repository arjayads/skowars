class CreateMembers < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE TYPE membership_type AS ENUM ('skowar', 'sponsor');
    SQL
    create_table :members do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.boolean :is_active
      t.column :category, :membership_type
      t.timestamps null: false
    end
  end

  def down
    drop_table :members
    execute <<-SQL
      DROP TYPE membership_type;
    SQL
  end
end
