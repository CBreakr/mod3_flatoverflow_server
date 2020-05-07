class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :question_id
      t.boolean :is_answered

      t.timestamps
    end
  end
end
