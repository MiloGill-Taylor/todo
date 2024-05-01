# == Schema Information
#
# Table name: tasks
#
#  id           :integer          not null, primary key
#  description  :string
#  name         :string
#  status       :integer          default(0)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  task_list_id :integer
#
# Indexes
#
#  index_tasks_on_task_list_id  (task_list_id)
#
# Foreign Keys
#
#  task_list_id  (task_list_id => task_lists.id)
#
class Task < ApplicationRecord
  belongs_to :task_list, optional: true

  enum status: {
    unstarted: 0,
    in_progress: 1,
    complete: 2,
  }
end
