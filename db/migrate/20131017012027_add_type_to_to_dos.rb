class AddTypeToToDos < ActiveRecord::Migration
  def up
    add_column :to_dos, :group, :string
    add_column :to_dos, :subgroup, :string
  end

  def down
    remove_column :to_dos, :group
    remove_column :to_dos, :subgroup
  end
end
