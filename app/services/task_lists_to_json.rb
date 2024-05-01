module Services
  class TaskListsToJson
    include Callable

    def initialize(task_lists:)
      @task_lists = task_lists
    end

    def call
      json = Hash.new

      @task_lists.each do |task_list|
        json[task_list.name] => task_list.tasks.map(&:to_json)
      end

      json
    end
  end
end
