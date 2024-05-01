class TasksController < ApplicationController
  before_action :process_json_body, only: [:create, :update]

  def create
    task = (list_id = @body["list_id"]) ? Task.create(task_list_id: list_id) : Task.create

    json = { id: task.id }

    render json:, status: :ok
  end

  def update
    Task.find(task_id).update(@body)
  end

  def destroy
    Task.find(task_id).destroy

    redirect_to root_url
  end

  private

  def task_id
    params.permit(:id)[:id].to_i
  end

  def process_json_body
    @body = JSON.parse(request.body.read)
  end
end
