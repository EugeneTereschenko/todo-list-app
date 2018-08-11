<template>
  <b-container class="trgray">
    <b-row align-v="center">
      <b-col cols="1">
        <icon name="plus" scale="2"></icon>
      </b-col>
      <b-col>
        <b-form-input type="text" class="add_task_input" 
        placeholder="Start typing here to create a task"
        v-model="value"></b-form-input>
       </b-col> 
        <b-col cols="2">  
        <date-picker  v-model="deadline" lang="en" 
        :not-before="new Date()" class="deadline" 
        placeholder="Select Deadline"  type="datetime" 
        format="DD-MM-YYYY hh:mm:ss" :minute-step="10" confirm></date-picker>
       </b-col>
        <b-col cols="2">
        <b-btn @click="addTask()" class="left">Add Task</b-btn>
       </b-col>
    </b-row>
    <b-row>
      <b-col cols="1">
      </b-col>
      <b-col>
        <span v-show="validName === false" class="red_error">Please Enter at least 3 letters</span>
      </b-col> 
        <b-col cols="2">  
        <span v-show="validDeadline === false" class="red_error">Deadline is required</span>
       </b-col>
        <b-col cols="2">
       </b-col>
    </b-row>
  </b-container>
</template>

<script>
export default {
  data() {
    return {
      value: "",
      deadline: null,
      validName: true,
      validDeadline: true
    };
  },
  methods: {
    clearName() {
      this.value = "";
    },
    isvalidName() {
      this.validName = this.value.length < 3 ? false : true;
      return this.validName;
    },
    isvalidDeadline() {
      this.validDeadline = this.deadline === null ? false : true;
      return this.validDeadline;
    },
    addTask() {
      this.isvalidName();
      this.isvalidDeadline()
      if (this.isvalidName() && this.isvalidDeadline()) {
        this.$emit("clicked", this.value, this.deadline);
        this.clearName();
      }
    }
  }
};
</script>

<style>
.add_task_input {
  width: 100%;
  float: left;
}
.deadline {
  width: 100%;
  float: left;
}
.trgray {
  background: #d1d1d1;
  height: 60px;
  background-clip: content-box;
}
.trgray svg {
  color: green;
}
.trgray button {
  background-color: green;
}
.red_error {
  float: left;
  font-weight: 7px;
  color: red;
  height: 9px;
}
</style>