class CreateQuestionTags < ActiveRecord::Migration[6.0]
  def change
    create_table :question_tags do |t|
      t.integer :tag_id
      t.integer :question_id

      t.timestamps
    end
  end
end
