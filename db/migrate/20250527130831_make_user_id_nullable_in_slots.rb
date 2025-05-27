class MakeUserIdNullableInSlots < ActiveRecord::Migration[8.0]
  def change
    change_column_null :slots, :user_id, true
  end
end
