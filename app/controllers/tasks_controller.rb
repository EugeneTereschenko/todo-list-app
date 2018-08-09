class TasksController < ApplicationController
    before_action :authenticate_user!
    
    def create
        project = Project.find(params[:project_id]) 
        newPriority = project.tasks.length + 1
        task = project.tasks.create(params.require(:task).permit(:name, :status, :deadline))
        task.update_attribute(:priority, newPriority)
        render json: task
    end
    def update
        task = Task.find(params[:id])
        task.update_attributes(params.require(:task).permit(:name, :status, :priority, :deadline))
        render json: task
    end
    def destroy
        task = Task.find(params[:id])
        task.destroy
        render json: task
    end
    def show
        task = Task.find(params[:id])
        render json: task
    end
    def index
        project = Project.find(params[:project_id])
        render json: project.tasks.order(:priority)
    end
    
    def up
        Task.up(params[:project_id], params[:task_id])
        project = Project.find(params[:project_id])
        render json: project.tasks.order(:priority) 
    end
    
    def down
        Task.down(params[:project_id], params[:task_id])
        project = Project.find(params[:project_id])
        render json: project.tasks.order(:priority)
    end 
end
