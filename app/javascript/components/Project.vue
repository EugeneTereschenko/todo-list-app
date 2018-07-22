<template>
  <div>
    <project_name :project="project" @delete_project="delProject" @edit_project="editProject"></project_name>
    
    <add_task_input :project="project" 
			placeholder="Start typing here to create a task"
			@clicked="addTask"></add_task_input>
    
    <tasks :tasks="tasks" @delete_task="delTask" @edit_task="editTask" @set_status_task="setStatus" @up_status_task="upStatus" @down_status_task="downStatus"></tasks>

  </div>
</template>

<script>
import project_name from "./ProjectName.vue";
import add_task_input from "./AddTask.vue";
import tasks from "./Tasks.vue";

export default {
  props: {
    project: {
      type: Object,
      required: true
    }
  },
  components: { tasks, add_task_input, project_name },
  data() {
    return {
      tasks: []
    };
  },
  methods: {
    addTask(newTaskName) {
      const trimmedText = newTaskName.trim();
      if (trimmedText) {
        this.$http
          .post(`/projects/${this.project.id}/tasks/`, {
            task: { name: trimmedText, status: "created" }
          })
          .then(response => {
            this.tasks.push(response.body);
            console.log(this.projects);
          });
      }
    },

    delProject(proj_id) {
      this.$emit("delete_project", proj_id);
    },

    editProject(proj_name, proj_id) {
      this.$emit("edit_project", proj_name, proj_id);
    },

    delTask(task_id) {
      this.$http
        .delete(`projects/${this.project.id}/tasks/${task_id}`)
        .then(response => {
          for (let i = 0; i < this.tasks.length; i++) {
            if (this.tasks[i].id === task_id) {
              console.log(i);
              this.tasks.splice(i, 1);
              break;
            }
          }

          console.log(this.tasks);
        });
    },

    editTask(task_name, task_id) {
      this.$http
        .put(`projects/${this.project.id}/tasks/${task_id}`, {
          task: { name: task_name }
        })
        .then(response => {
          for (let i = 0; i < this.tasks.length; i++) {
            if (this.tasks[i].id === task_id) {
              console.log(i);
              this.tasks.splice(i, 1, response.body);
              break;
            }
          }

          console.log(this.tasks);
        });
    },

    setStatus(task_name, task_id) {
      this.$http
        .put(`projects/${this.project.id}/tasks/${task_id}`, {
          task: { status: "completed" }
        })
        .then(response => {
          // get body data

          for (let i = 0; i < this.tasks.length; i++) {
            if (this.tasks[i].id === task_id) {
              console.log(i);
              this.tasks.splice(i, 1, response.body);
              break;
            }
          }

          console.log(this.tasks);
        });
    },

    upStatus(task_name, task_id) {
      this.$http
        .get(`projects/${this.project.id}/tasks/${task_id}/up`)
        .then(response => {
          // get body data

          this.tasks = response.body;

          console.log(this.tasks);
        });
    },

    downStatus(task_name, task_id) {
      this.$http
        .get(`projects/${this.project.id}/tasks/${task_id}/down`)
        .then(response => {
          // get body data

          this.tasks = response.body;

          console.log(this.tasks);
        });
    }
  },

  created() {
    this.$http.get(`/projects/${this.project.id}/tasks/`).then(
      response => {
        // get body data
        this.tasks = response.body;
      },
      response => {
        // error callback
      }
    );
  }
};
</script>

<!--<style lang="scss" scoped>
@import url("//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css");
</style>-->