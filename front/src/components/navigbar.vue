<template>
  <div id="navigbar">
    <div>
      <b-navbar type="dark" variant="dark" class="nav">
        <b-navbar-brand tag="h1" class="mb-0">Serov</b-navbar-brand>
        <b-navbar-nav>
          <b-button v-b-modal.modal-1 variant="link">Изменить список стран</b-button>
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
      options: [
        { value: 'a', text: 'This is First option' },
        { value: 'b', text: 'Default Selected Option' },
        { value: 'c', text: 'This is another option' },
        { value: 'd', text: 'This one is disabled', disabled: true },
        { value: 'e', text: 'This is option e' },
        { value: 'f', text: 'This is option f' },
        { value: 'g', text: 'This is option g' }
      ],
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
