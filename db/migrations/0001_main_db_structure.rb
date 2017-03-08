Sequel.migration do
  up do
    create_table(:winuser) do
      primary_key :id
      String :pc_name
      String :malware_id
    end
    create_table(:folder) do
      primary_key :id
      String :path
      foreign_key :winuser_id, :winuser
    end
    create_table(:fileinfo) do
      primary_key :id
      String :file
      Integer :size
      foreign_key :winuser_id, :winuser
      foreign_key :folder_id, :folder
    end
  end
  down do
    drop_table(:fileinfo)
    drop_table(:folder)
    drop_table(:winuser)
  end
end
