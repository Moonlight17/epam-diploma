<template>
  <div id="app">
    <div v-for="country in clist" :key="country.id" class="row justify-content-lg-center country_pos">
      <div id="tables" class="col-sm-12 col-md-12 col-lg-12 col-xl-10 col-xl-8">
        <div class="input-group mb-3">
          <span class="input-group-text" id="basic-addon1">{{ country }}</span>
          <b-form-input
              id="filter-input"
              v-model="filter[country]"
              type="search"
              placeholder="Type to Search"
              size="sm"
              class="input_filter"
          ></b-form-input>
          <button type="button" class="btn btn-outline-secondary" @click="filter[country] = ''">Clear</button>
        </div>
        <b-table
            :items="data[country]"
            :filter="filter[country]"
            :fields="fields"
            :sort-by.sync="sortBy"
            :sort-desc.sync="sortDesc"
            :sort-direction="sortDirection"
            label-sort-asc=""
            label-sort-clear=""
            label-sort-desc=""
            show-empty
            hover
        >
        </b-table>
      </div>
    </div>

  </div>
</template>
<script>
// import axios from 'axios';
export default {
  components:{
  },
  props: {
    data: Object,
    clist: Array,
  },
  name: 'DataTable',
  data() {
    return {
      filter: {},
      fields: [
        {
          label: 'ID',
          key: 'id',
          sortable: true,
        },
        {
          label: 'Date',
          key: 'date_value',
          sortable: true,
        },
        {
          key: 'confirmed',
          label: 'Confirmed',
          sortable: true,
        },
        {
          key: 'deaths',
          label: 'Deaths',
          sortable: true,
        },
        {
          key: 'stringency_actual',
          label: 'Stringency Actual',
          sortable: true,
        },
        {
          key: 'stringency',
          label: 'Stringency',
          sortable: true,
        },
        {
          key: 'stringency_legacy',
          label: 'Stringency Legacy',
          sortable: true,
        },
        {
          key: 'stringency_legacy_disp',
          label: 'Stringency legacy disp',
          sortable: true,
        },
        {
          key: 'country_name',
          label: 'Country',
          sortable: true,
        }
      ],
      sortBy: '',
      sortDesc: false,
      sortDirection: 'asc',
    }
  },
  mounted: function() {
  },
  methods: {
  },
  computed: {

  }
}
</script>
<style scoped>
#app{
  width: 100%;
}
.input_filter{
  width: 100px;
}
.country_pos{
  margin-bottom: 8%;
}
.test_block{
  background-color: red;
}
</style>