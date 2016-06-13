Sequel.migration do
  change do
    create_table("") do
      primary_key :id, type: :serial
    end
  end
end