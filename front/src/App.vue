<template>
  <div id="app">
    <navigBlock :list="list_countries" />
    <img alt="Vue logo" src="./assets/logo.png">
    <div class="container-fluid">
      <DataTable :clist="clist" :data="data_countries" />
    </div>

    <b-modal size="lg" no-close-on-backdrop scrollable centered id="modal-1" ref="countriesModal">
      <div id="search">
        <b-table
            :items="list_countries"
            :fields="fields"
            :sort-by.sync="sortBy"
            :sort-desc.sync="sortDesc"
            :sort-direction="sortDirection"
            :select-mode="selectMode"
            label-sort-asc=""
            label-sort-clear=""
            label-sort-desc=""
            show-empty
            ref="selectableTablecountry"
            selectable
            @row-selected="onRowSelected"
        >
        </b-table>
      </div>
      <template #modal-header >
        <!-- Emulate built in modal header close button action -->
        <div class="container-fluid row">
          <div class="col-9">
            <h5>Select countries (use ctrl/cmd + click for multiselect)</h5>
          </div>
          <div class="col-3">
            <b-button-group size="sm" >
              <b-button variant="light" @click="selectAllRows">Select all</b-button>
              <b-button variant="light" @click="clearSelected">Clear selected</b-button>
            </b-button-group>
          </div>
        </div>

      </template>
      <template #modal-footer="{  }">
      <!-- Emulate built in modal footer ok and cancel button actions -->
      <b-button size="sm" :disabled="status" variant="success" @click="ready_send()">
        Send
      </b-button>
    </template>
    </b-modal>

<!--    <pre>{{$data.data_countries}}</pre>-->
  </div>
</template>

<script>
import DataTable from './components/DataTable.vue'
import navigBlock from "@/components/navigbar";
import axios from "axios";

export default {
  name: 'App',
  components: {
    DataTable,
    navigBlock
  },
  data() {
    return {
      main_url: process.env.VUE_APP_URL,
      data_countries: {},
      clist: [],
      selectMode: 'multi',
      selected: [],
      sortBy: '',
      sortDesc: false,
      sortDirection: 'asc',
      fields: [
        {
          label: 'ID',
          key: 'id',
          sortable: true,
        },
        {
          label: 'Country code',
          key: 'text',
          sortable: true,
        },
        {
          label: 'Date added',
          key: 'pub_date',
          sortable: true,
        },
        {
          label: 'Number of records',
          key: 'count_data',
          sortable: true,
        },
      ],
      list_countries: [],
      line_select: [],
      line_error:null,


    }
  },
  created: function () {
    this.FetchData();
    // this.GetDataCountry();
  },
  mounted: function () {
    this.toggleModal();
  },
  methods: {
    ready_send(){
      if(this.selected.length > 0){
        this.GetDataCountry();
        this.hideModal();
      } else {
        alert("you need select country or countries");
      }

    },
    toggleModal() {
      this.$root.$emit('bv::toggle::modal', 'modal-1', '#btnToggle')
    },
    hideModal() {
      this.$root.$emit('bv::hide::modal', 'modal-1', '#btnShow')
    },
    FetchData: function () {
      axios.get(this.main_url + "country/").then(response => {
        this.list_countries = response.data;
      });
    },
    GetDataCountry: function () {
      this.toggleModal();
      let need_list=[];
      for (const i in this.selected) {
        need_list[i]=this.selected[i].text;
      }
      axios.post(this.main_url + "stat/", {data: need_list}).then(response => {
        this.data_countries = response.data;
        this.clist = Object.keys(this.data_countries);
      });
    },
    onRowSelected(items) {
      this.line_select = [];
      for (let i in items){
        this.line_select.push(this.list_countries.indexOf(items[i]));
      }
      // console.log(this.line_select);
      this.selected = items;
    },
    selectAllRows() {
      this.$refs.selectableTablecountry.selectAllRows()
    },
    clearSelected() {
      this.$refs.selectableTablecountry.clearSelected()
    },
    vibor() {
      setTimeout(() => {
        for (let i in this.line_select){
          this.$refs.selectableTablecountry.selectRow(this.line_select[i]);
        }
        
      },1);
    },
  },
  computed: {
    status: function (){
      return !(this.selected.length > 0)
    }
  }
}
</script>

<style>
body{
  min-width:900px;        /* Suppose you want minimum width of 1000px */
  width: auto !important;  /* Firefox will set width as auto */
  /*width:1000px;            !* As IE6 ignores !important it will set width as 1000px; *!*/
}
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  /*margin-top: 60px;*/
}
</style>
