<template>
  <b-container class="trgray">
    <b-row align-v="center" class="padding10">
      <b-col cols="1">
        <icon name="plus" scale="2"></icon>
      </b-col>
      <b-col>
        <div class = "edit_item">
        <b-form-input type="text" class="add_task_input" 
        placeholder="Start typing here to create a task"
        v-model="value"></b-form-input>
        <span v-show="validName === false" class="red_error">Please Enter at least 3 letters</span>
        </div>
       </b-col> 
        <b-col cols="2" class = "datepickerpadding">
        <div class = "edit_item">
        <date-picker  v-model="deadline" lang="en" 
        :not-before="new Date()" class="deadline" 
        placeholder="Select Deadline"  type="datetime" 
        format="DD-MM-YYYY hh:mm:ss" :minute-step="10" confirm></date-picker>
        <span v-show="validDeadline === false" class="red_error">Deadline is required</span>
        </div>
       </b-col>
        <b-col cols="2" class = "button_padding">
        <b-btn @click="addTask()" class="left">Add Task</b-btn>
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
      this.isvalidDeadline();
      if (this.isvalidName() && this.isvalidDeadline()) {
        this.$emit("clicked", this.value, this.deadline);
        this.clearName();
      }
    }
  }
};
</script>

<style>
.datepickerpadding {
  padding-left: 0px;
}
.button_padding {
  padding-bottom: 30px;
  padding-left: 0px;
}
.padding10 {
  padding-top: 10px;
}
.add_task_input {
  width: 100%;
  float: left;
}
.deadline {
  width: 100%;
  float: left;
}
.deadline input {
  height: 38px;
  font-size: 16px;
}
.trgray {
  background: #d1d1d1;
  height: 70px;
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
}
</style>