<template>
  <div class="project">
    <ul v-if="projects.length">
      <project
        v-for="project in projects"
        :key="project.id"
        :project="project"
        @delete_project="delProject"
        @edit_project="editProject"
      ></project>
    </ul>
    <!-- Button add new Project -->
    <project_add_btn @submitted="addProject"></project_add_btn>
  </div>
</template>
<script>
import project from "./Project.vue";
import project_add_btn from "./AddProject.vue";

export default {
  data() {
    return {
      projects: []
    };
  },
  components: { project, project_add_btn },
  methods: {
    addProject(proj_name) {
      this.$http
        .post("/projects/", { project: { name: proj_name } })
        .then(response => {
          this.projects.push(response.body);
          console.log(this.projects);
        });
    },

    delProject(proj_id) {
      this.$http.delete("/projects/" + proj_id).then(response => {
        for (let i = 0; i < this.projects.length; i++) {
          if (this.projects[i].id === proj_id) {
            console.log(i);
            this.projects.splice(i, 1);
            break;
          }
        }

        console.log(this.projects);
      });
    },

    editProject(proj_name, proj_id) {
      this.$http
        .put("/projects/" + proj_id, { project: { name: proj_name } })
        .then(response => {
          for (let i = 0; i < this.projects.length; i++) {
            if (this.projects[i].id === proj_id) {
              console.log(i);
              this.projects.splice(i, 1, response.body);
              break;
            }
          }

          console.log(this.projects);
        });
    }
  },
  created() {
    this.$http.get("/projects").then(
      response => {
        // get body data
        this.projects = response.body;
      },
      response => {
        // error callback
      }
    );
  }
};
</script>

<style>
.project {
  min-height: 200px;
}
</style>