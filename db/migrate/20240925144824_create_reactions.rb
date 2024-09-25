class CreateReactions < ActiveRecord::Migration[7.1]
  def change
    create_table :reactions do |t|
      t.integer :status, null: false, default: 0
      t.references :user, null: false, foreign_key: true
      t.string :reactionable_type, null: false
      t.integer :reactionable_id, null: false

      t.timestamps
    end

    add_index :reactions, [:reactionable_type, :reactionable_id]
  end
end
