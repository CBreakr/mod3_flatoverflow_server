class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :question_id
      t.integer :user_id
      t.string :text
      t.boolean :is_answer

      t.timestamps
    end
  end
end
