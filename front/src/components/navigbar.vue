<template>
  <div id="navigbar">
    <div>
      <b-navbar type="dark" variant="dark" class="nav">
        <b-navbar-brand tag="h1" class="mb-0">Serov</b-navbar-brand>
        <b-navbar-nav>
          <b-button v-b-modal.modal-1 variant="link" @click="$parent.vibor()">Change the list of countries</b-button>
<!--          <b-nav-item href="#">Link</b-nav-item>-->
<!--          <b-nav-item href="#" disabled>Disabled</b-nav-item>-->
        </b-navbar-nav>

<!--        <b-navbar-nav>-->
<!--          &lt;!&ndash; Navbar dropdowns &ndash;&gt;-->
<!--          <b-nav-item-dropdown text="User" right>-->
<!--            <b-dropdown-item href="#">Account</b-dropdown-item>-->
<!--            <b-dropdown-item href="#">Settings</b-dropdown-item>-->
<!--          </b-nav-item-dropdown>-->
<!--        </b-navbar-nav>-->
      </b-navbar>
    </div>
  </div>
</template>

<script>
export default {
  name: "navigBlock",
  // props: ['list'],
  props: {
    list: Array,
  },
  data(){
    return{
      list_countries:null,
      selected: [],
    }
  }
}
</script>

<style scoped>
.nav{
  padding: 10px 3%;
}
.drop-downbox{
  color: red;
}
</style>
