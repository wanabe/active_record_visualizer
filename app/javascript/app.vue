<template>
  <div id="app">
    <button @click="load()">Load</button>
    <ul>
      <li v-for="modelClass in modelClasses.nodes">
        <input type="checkbox" name="model_class" v-bind:value="modelClass.name" checked="checked"></input>
        {{ modelClass.name }}
        <ul>
          <li v-for="association in modelClass.associations.nodes">
            <input type="checkbox" name="model_association" v-bind:value="modelClass.name + '-' + association.name" checked="checked"></input>
            {{ association.name }} -> {{ association.klass }}
          </li>
        </ul>
      </li>
    </ul>
    <pre>{{ raw }}</pre>
  </div>
</template>

<script>
  import gql from 'graphql-tag'

  export default {
    data: function () {
      return {
        raw: '',
        modelClasses: {}
      }
    },
    methods: {
      load () {
        const QUERY = gql`
          query($exceptClasses: [String!], $exceptAssociations: [String!]) {
            modelClasses(except: $exceptClasses) {
              nodes {
                name
                associations(exceptClasses: $exceptClasses, except: $exceptAssociations) {
                  nodes {
                    name
                    klass
                  }
                }
              }
            }
          }
        `
        this.$apollo.query({
          query: QUERY
        }).then((result) => {
          this.$data.raw = result.data
          this.$data.modelClasses = result.data.modelClasses
        }).catch((error) => {
          alert(error)
        })
      }
    }
  }
</script>

<style scoped>
</style>
