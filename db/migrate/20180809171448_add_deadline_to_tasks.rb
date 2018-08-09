class AddDeadlineToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline, :timestamp
  end
end
