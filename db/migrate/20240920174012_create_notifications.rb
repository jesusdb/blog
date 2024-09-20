class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.string :message, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :recipient_id
      t.string :notifiable_type
      t.integer :notifiable_id

      t.timestamps
    end

    add_index :notifications, [:notifiable_type, :notifiable_id]
    add_index :notifications, :recipient_id
  end
end
