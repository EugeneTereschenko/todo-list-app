<template>
    <b-container class="table_task">
      <b-table hover :items="tasks" :fields="fields" class="bg-white text-dark">
        <template slot="actions" slot-scope="row">
        <div class="sml-btn-tasks">
        <div class="btn-group-vertical">
          <b-btn size="sm" @click.stop="upTask(row.item.id, row.item.name)" class="mr-2 buttonUp">
            <icon name="angle-up"></icon>
          </b-btn>
          <b-btn size="sm" @click.stop="downTask(row.item.id, row.item.name)" class="mr-2 buttonDown">
            <icon name="angle-down"></icon>
          </b-btn>
        </div>
          <b-btn size="sm" @click.stop="showEditTask(row.item.id, row.item.name, row.item.deadline)" class="mr-2">
            <icon name="pencil"></icon>
          </b-btn>
          <b-btn size="sm" @click.stop="delTask(row.item.id)" class="mr-2">
            <icon name="trash"></icon>
          </b-btn>
        </div>
        </template>
        <template slot="status" slot-scope="row">
          <b-form-checkbox v-model="row.item.status"
                     value="completed"
                     unchecked-value="created" 
                     @click.native.stop @change="setStatus(row.item.id, row.item.name)">
          </b-form-checkbox>
        </template>
      </b-table>

      <!-- Edit modal -->
      <b-modal id="modalEditTask"
            ref="editTask"
            title="Edit task name or deadline"
                @ok="handleOk">
            <form @submit.stop.prevent="handleSubmit">
                  <div class = "edit_item">
                  <b-form-input type="text"
                        v-model="name"></b-form-input>
                <span v-show="validName === false" class="red_error">Please Enter at least 3 letters</span>
                </div>
                <div class = "edit_item">
                <date-picker  v-model="deadline" lang="en" 
                :not-before="new Date()" 
                class="deadline"  
                type="datetime" format="DD-MM-YYYY hh:mm:ss" 
                :minute-step="10" confirm></date-picker>
                <span v-show="validDeadline === false" class="red_error">Deadline is required</span>
                </div>
            </form>
    </b-modal >
    </b-container>
</template>

<script>
export default {
  props: {
    tasks: {
      type: Array,
      required: true
    }
  },
  data() {
    return {
      name: "",
      id: "",
      deadline: "",
      validName: true,
      validDeadline: true,
      fields: [
        {
          key: "status",
          class: "col-1"
        },
        {
          key: "name",
          class: "text-left"
        },
        {
          key: "deadline",
          class: "col-2",
          formatter: (value, key, item) => {
            if (item.deadline === null) {
              item.deadline = new Date();
            }
            return  this.format(item.deadline);
          }
        },
        {
          key: "actions",
          class: "col-2"
        }
      ]
    };
  },
  methods: {
    delTask(task_id) {
      this.$emit("delete_task", task_id);
    },
    showEditTask(task_id, task_name, deadline) {
      this.name = task_name;
      this.id = task_id;
      this.deadline = new Date(deadline);
      this.$refs.editTask.show();
    },
    isvalidName() {
      this.validName = this.name.length < 3 ? false : true;
      return this.validName;
    },
    isvalidDeadline() {
      this.validDeadline = this.deadline === null ? false : true;
      return this.validDeadline;
    },
    handleOk(evt) {
      // Prevent modal from closing
      evt.preventDefault();
      this.isvalidName();
      this.isvalidDeadline()
      if (this.isvalidName() && this.isvalidDeadline()) {
        this.handleSubmit();
      }
    },

    handleSubmit() {
      this.$emit("edit_task", this.name, this.id, this.deadline);
      this.$refs.editTask.hide();
    },

    setStatus(task_id, task_name) {
      this.$emit("set_status_task", task_name, task_id);
    },

    upTask(task_id, task_name) {
      this.$emit("up_status_task", task_name, task_id);
    },

    downTask(task_id, task_name) {
      this.$emit("down_status_task", task_name, task_id);
    },
    format(deadline) {
      return this.$moment(deadline).format("DD-MM-YYYY hh:mm:ss");;
    }
  }
};
</script>

<style>
table {
  border-bottom-right-radius: 25px;
  border-bottom-left-radius: 25px;
  word-break: break-all;
  background-color: #ffffff;
}
table > thead {
  display: none !important;
}
table tr:hover {
  cursor: pointer;
}
.edit_item {
  height: 70px;
}
.sml-btn-tasks {
  height: 50px;
}
.sml-btn-tasks button {
  background-color: transparent;
  border-color: transparent;
  color: #d1d1d1;
  display: none;
}
.table_task tr:hover button {
  display: inline;
  background-color: transparent;
  border-color: transparent;
  color: #888888;
}
table td {
  border-right: 1px solid #ddd;
  border-top: 1px solid #ddd;
}
table tr {
  height: 45px;
}

table td:last-child {
  border-right: none;
}
.buttonUp {
  height: 18px;
}
.buttonDown {
  height: 18px;
}
</style>