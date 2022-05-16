<template>
  <div id="app" class="none_block">
    <button @click="SelectWinner()">Select a Winner#1</button>
    <div id="select_block">
      <div id="search">
        <label for="input-with-list">Input with datalist</label>
        <b-input-group id="input_countries_styles" class="mt-3">
          <template #append>
            <b-button variant="info" @click="task_add()">Button</b-button>
          </template>
          <b-form-input :state="line_error" id="input_countries" list="countries" v-model="line_select"></b-form-input>
        </b-input-group>

<!--        <b-form-datalist class="mb-6" v-model="selected" id="countries" :options="list_countries"></b-form-datalist>-->

<!--        <b-form-input id="input_countries" list="countries"></b-form-input>-->
        <datalist id="countries">
          <option v-for="item in list_countries" :key="item.text">{{ item.text }}</option>
        </datalist>
<!--        <b-form-select id="input_countries_styles" value-field="text" v-model="selected" :options="list_countries" multiple :select-size="4"></b-form-select>-->
      </div>
      <div id="list">
        <ul>
<!--          <li v-for="item in selected_countries" :key="item.id">{{item}}</li>-->
          <li v-for="item in selected" :key="item">{{item}}</li>
        </ul>
      </div>

    </div>
    <p>
<!--      {{ urls }}-->
    </p>
<!--    <b-table-->
<!--        :items="items"-->
<!--        :fields="fields"-->
<!--        :filter="filter"-->
<!--        :filter-included-fields="filterOn"-->
<!--        stacked="md"-->
<!--        @filtered="onFiltered"-->
<!--    >-->
  </div>
</template>
<script>
// import axios from 'axios';
export default {
  components:{
  },
  props: {
    list_countries: Array,
  },
  name: 'App',
  data() {
    return {
      selected: [],
      line_select: '',
      line_error:null,
    }
  },
  mounted: function() {
  },
  methods: {
    task_add: function () {
      // let obj = this.list_countries.find(item => item.text === id)
      if (this.line_select && this.selected.length<11){
        this.line_error=null;
        this.selected.push(this.line_select);
        this.line_select=null;
      } else{
        this.line_error=false;
      }
    }

  },
  computed: {
    // selected_countries: function(){
    //   var list = [];
    //
    //   return list
    // }
  }
}
</script>
<style scoped>
.none_block{
  /*display: none;*/
  /*opacity: 100%;*/
}
#select_block{
  /*position: absolute;*/
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 50%;
  border-radius: 7px;
  border: 1px solid black;
  min-height: 500px;
}
#input_countries_styles{
  position: absolute;
  top: 30%;
  left: 50%;
  transform: translate(-50%, -50%);
  min-width: 50px;
}
/*#selected_countries_styles{*/
/*  position: absolute;*/
/*  top: 30%;*/
/*  left: 50%;*/
/*  transform: translate(-50%, -50%);*/
/*  min-width: 50px;*/
/*}*/
</style>