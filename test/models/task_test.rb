# == Schema Information
#
# Table name: tasks
#
#  id           :integer          not null, primary key
#  description  :string
#  name         :string
#  status       :integer          default("unstarted")
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
require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
