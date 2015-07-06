class CreateMembers < ActiveRecord::Migration
  def up
    execute <<-SQL
      CREATE TYPE membership_type AS ENUM ('Skowar', 'Sponsor');
      CREATE TYPE gender AS ENUM ('Male', 'Female');
    SQL
    create_table :members do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :email, null: false
      t.string :username
      t.string :password_digest, null: false
      t.string :activation_code
      t.boolean :is_active, null: false, default: false
      t.date :dob
      t.column :category, :membership_type, null:false
      t.column :gender, :gender, null:false
      t.timestamps null: false
    end
  end

  def down
    drop_table :members
    execute <<-SQL
      DROP TYPE membership_type;
      DROP TYPE gender;
    SQL
  end
end
