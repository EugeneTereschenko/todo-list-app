<template>
  <b-container class="trgray">
    <b-row align-v="center">
      <b-col cols="1">
        <icon name="plus" scale="2"></icon>
      </b-col>
      <b-col cols="11">
        <b-form-input type="text" class="add_task_input"
        placeholder="Start typing here to create a task"
        v-model="value"></b-form-input>
        <b-btn @click="addTask()" class="left">Add Task</b-btn>
       </b-col>
    </b-row>
  </b-container>
</template>

<script>
export default {
  data() {
    return {
      value: ""
    };
  },
  methods: {
    clearName() {
      this.value = "";
    },
    addTask() {
      this.$emit("clicked", this.value);
      this.clearName();
    }
  }
};
</script>

<style>
.add_task_input {
  width: 80%;
  float: left;
}
.trgray {
  background: #d1d1d1;
  height: 45px;
  background-clip: content-box;
}
.trgray svg {
  color: green;
}
.trgray button {
  background-color: green;
}
</style>