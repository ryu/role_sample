class AddNotNullToRoleName < ActiveRecord::Migration[8.1]
  def change
    change_column_null :roles, :name, false
  end
end
