class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.integer :status, default: 0
      t.references :task_list, null: true, foreign_key: true

      t.timestamps
    end
  end
end
