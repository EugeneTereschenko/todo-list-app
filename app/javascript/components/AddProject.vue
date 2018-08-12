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
      <div class = "edit_item">
        <b-form-input type="text"
    placeholder="Enter project name"
    v-model="name"></b-form-input>
            <span v-show="validName === false" class="red_error">Please Enter at least 3 letters</span>
      </div>
      </form>
    </b-modal >
  </div >
</template >

  <script>
export default {
  data() {
    return {
      name: "",
      validName: true     
    };
  },

  methods: {
    clearName() {
      this.name = "";
    },

    handleOk(evt) {
      // Prevent modal from closing
      evt.preventDefault();
      if (this.name.length < 3) {
        this.validName = false;
      } else {
        this.validName = true;
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