Sequel.migration do
  up do
    create_table(:user) do
      primary_key :id
      String :user_name, null: false
      String :email, null: false, unique: true
      String :password_hash, null: false
    end
    create_table(:userlog) do
      primary_key :id
      DateTime :timestamp, null: false
      String :activity_type, null: false
      String :activity, null: false
      foreign_key :user_id, :user
    end
  end
  down do
    drop_table(:userlog)
    drop_table(:user)
  end
end
