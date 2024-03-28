class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.text :body
      t.references :chat, null: false, foreign_key: true
      t.string :message_number

      t.timestamps
    end
  end
end
