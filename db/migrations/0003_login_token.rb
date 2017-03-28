Sequel.migration do
  up do
    create_table(:login_token) do
      primary_key :id
      String :token, null: false
      DateTime :expiry_date, null: false, unique: true
      foreign_key :user_id, :user
    end
  end
  down do
    drop_table(:login_token)
  end
end
