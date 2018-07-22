class Task < ApplicationRecord
  validates :name, presence: true,
                        length: { minimum: 1 }
  belongs_to :project
    
    after_destroy :update_priority

    def Task.up(project_id, task_id)
        project = Project.find(project_id)
        taskcurrent = project.tasks.find(task_id)
        prioritycurrent = taskcurrent.priority
        
        if prioritycurrent != 1
            priorityUp = prioritycurrent-1
            taskUp = project.tasks.find_by(priority: priorityUp) 
            taskcurrent.update_attribute(:priority, priorityUp)
            taskUp.update_attribute(:priority, prioritycurrent)
        
        end
        
    end


    def Task.down(project_id, task_id)
        project = Project.find(project_id)
        taskcurrent = project.tasks.find(task_id)
        prioritycurrent = taskcurrent.priority
        maxpriority = project.tasks.maximum("priority")
        
        if prioritycurrent != maxpriority
            priorityDown = prioritycurrent+1
            taskDown = project.tasks.find_by(priority: priorityDown) 
            taskcurrent.update_attribute(:priority, priorityDown)
            taskDown.update_attribute(:priority, prioritycurrent)
        end
    end 


        def update_priority

            project = Project.find(project_id)
            all_tasks = project.tasks
            all_tasks.all.each_with_index { |n, i| n.update_attribute(:priority, i+1) }

        end
    
end
