class TaskListsController < ApplicationController

  def index
    @lists = TaskList.all
  end

  def create
  end

  def update
  end

  def destroy
  end
end
