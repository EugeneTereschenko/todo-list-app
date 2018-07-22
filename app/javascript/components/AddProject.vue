<template>
  <div>
    <b-btn v-b-modal.modalPrevent variant="primary">
      <icon name="plus"></icon>
      <span>Add TODO List</span>
    </b-btn>
  <!-- Main UI -->
    <div class="mt-3 mb-3">
  </div>
  <!-- Modal Component -->
    <b-modal id="modalPrevent"
    ref="modal"
    title="Submit project name"
             @ok="handleOk"
             @shown="clearName">
      <form @submit.stop.prevent="handleSubmit">
        <b-form-input type="text"
    placeholder="Enter project name"
    v-model="name"></b-form-input>
      </form>
    </b-modal >
  </div >
</template >

  <script>
export default {
  data() {
    return {
      name: ""
    };
  },

  methods: {
    clearName() {
      this.name = "";
    },

    handleOk(evt) {
      // Prevent modal from closing
      evt.preventDefault();
      if (!this.name) {
        alert("Please enter project name");
      } else {
        this.handleSubmit();
      }
    },

    handleSubmit() {
      this.$emit("submitted", this.name);
      this.clearName();
      this.$refs.modal.hide();
    }
  }
};
</script>