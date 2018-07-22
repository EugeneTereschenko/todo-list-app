<template>
  <div id="app">
    <h3>SIMPLE TODO LIST</h3>
    <p>FROM RUBY GARAGE</p>
    <!-- List of projects with tasks -->
    <projects></projects>
  </div>
</template>

<script>
import projects from "./components/Projects.vue";

export default {
  name: "App",
  components: { projects }
};
</script>

<style>
body {
  background: linear-gradient(to top, #d59813, #dad2c7) fixed;
}
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
.left {
  float: left;
}
.right {
  float: right;
}
</style>