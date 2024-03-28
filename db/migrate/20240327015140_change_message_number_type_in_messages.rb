class ChangeMessageNumberTypeInMessages < ActiveRecord::Migration[7.1]
  def change
    change_column :messages, :message_number, :integer
  end
end
