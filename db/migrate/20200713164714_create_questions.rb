class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :mapping
      t.references :role

      t.integer :priority
      t.string :question
      t.string :teaming_stage
      t.integer :appears
      t.integer :frequency
      t.string :type_question
      t.boolean :required, default: false
      t.string :condition

      t.timestamps
    end
  end
end
