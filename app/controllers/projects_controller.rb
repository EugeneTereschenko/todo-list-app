class ProjectsController < ApplicationController
    
    before_action :authenticate_user!
    protect_from_forgery prepend: true

    
    def index
        user = User.find_by_id(current_user)
        render json: user.projects
    end
    def create    
        user = User.find_by_id(current_user)
        logger.warn current_user
        logger.warn " TEST "
        project = user.projects.create(params.require(:project).permit(:name))
        render json: project
        
        
        
        
    end 
    def destroy
        user = User.find_by_id(current_user)
        project = user.projects.find(params[:id])
        project.destroy
        render json: project
    end
    def update
       project = Project.find(params[:id])
       project.update_attributes(params.require(:project).permit(:name))
       render json: project
    end
    def show 
      project = Project.find(params[:id])
      render json: project
    end  
end
