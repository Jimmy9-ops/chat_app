class CreateChats < ActiveRecord::Migration[7.1]
  def change
    create_table :chats do |t|
      t.references :application, null: false, foreign_key: true
      t.integer :messages_count
      t.integer :chat_number

      t.timestamps
    end
  end
end
