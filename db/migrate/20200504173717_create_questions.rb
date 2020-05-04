class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer :user_id
      t.string :text
      t.string :update_note
      t.boolean :is_answered

      t.timestamps
    end
  end
end
