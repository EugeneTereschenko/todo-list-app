<template>
<div>
  <b-container class="blue-header">
    <b-row class="padding10">
      <b-col cols="1">
          <icon name="list-alt"></icon>
      </b-col>
      <b-col cols="8">
        <h3>{{ project.name }}</h3>
      </b-col>
      <b-col cols="3" class="sm-btn-project">
        <b-btn size="sm" @click.stop="delProject" class="mr-2">
          <icon name="trash"></icon>
        </b-btn>
        <b-btn size="sm" @click.stop="showEditProject" class="mr-2">
          <icon name="pencil" class="right"></icon>
        </b-btn>
      </b-col>
    </b-row>
  </b-container>
  <b-modal id="modalEditProject"
            ref="editProject"
            title="Edit project name"
                @ok="handleOk"
                @shown="putName">
            <form @submit.stop.prevent="handleSubmit">
              <div class = "edit_item">
                <b-form-input type="text"
                        v-model="name"></b-form-input>
                <span v-show="validName === false" class="red_error">Please Enter at least 3 letters</span>
              </div>
            </form>
    </b-modal >
  </div>
</template>

<script>
export default {
  props: {
    project: {
      type: Object,
      required: true
    }
  },

  data() {
    return {
      name: "",
      validName: true
    };
  },

  methods: {
    delProject() {
      this.$emit("delete_project", this.project.id);
    },

    showEditProject() {
      this.$refs.editProject.show();
    },

    putName() {
      this.name = this.project.name;
    },
    isvalidName() {
      this.validName = this.name.length < 3 ? false : true;
      return this.validName;
    },
    handleOk(evt) {
      // Prevent modal from closing
      evt.preventDefault();
      if (this.isvalidName()) {
        this.handleSubmit();
      }
    },

    handleSubmit() {
      this.$emit("edit_project", this.name, this.project.id);
      this.$refs.editProject.hide();
    }
  }
};
</script>

<style>
.blue-header {
  background: linear-gradient(to bottom,#2989d8 10%,#207cca 91%,#7db9e8 100%);
  margin-top: 30px;
  height: 45px;
  background-clip: content-box;
}
.blue-header:hover {
      cursor: pointer;
}

.blue-header button {
    display: none;
}
.blue-header:hover button {
   display : inline;
   float: right;
   background-color: transparent;
   border-color: transparent;
}
.blue-header h3 {
  color: #ffffff;
  text-align: left;
}
</style>
