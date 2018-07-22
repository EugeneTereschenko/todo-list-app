/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

console.log('Hello World from Webpacker')

import Vue from "vue";
import TurbolinksAdapter from 'vue-turbolinks';
import VueResource from "vue-resource";
import BootstrapVue from "bootstrap-vue";
import bModal from "bootstrap-vue/es/components/modal/modal";
import bModalDirective from "bootstrap-vue/es/directives/modal/modal";
import "bootstrap/dist/css/bootstrap.css";
import "bootstrap-vue/dist/bootstrap-vue.css";
import "vue-awesome/icons";
import Icon from "vue-awesome/components/Icon";
import App from "../app";

Vue.component("icon", Icon);
Vue.use(BootstrapVue);
Vue.component("b-modal", bModal);
Vue.directive("b-modal", bModalDirective);
Vue.use(VueResource);
Vue.use(TurbolinksAdapter);

Vue.config.productionTip = false;

document.addEventListener('DOMContentLoaded', () => {

    Vue.http.headers.common['X-CSRF-Token'] = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute('content');

    
    const app = new Vue({
        el: '#app',
        render: h => h(App)
    });
});