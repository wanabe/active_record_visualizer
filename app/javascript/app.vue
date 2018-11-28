<template>
  <div id="app">
    <p v-if="!loaded">loading ...</p>

    <select v-if="loaded" v-model="type" @change="reset">
      <option>mermaid</option>
      <option>graphviz</option>
    </select>
    <button v-if="loaded" @click="getText()">get text</button>
    <button v-if="text.length > 0" @click="draw()">draw with</button>
    <div id="mermaidParent"></div>
    <textarea v-model="text"></textarea>
    <ul>
      <li v-for="modelClass in modelClasses.nodes">
        <input type="checkbox" v-model="classNames" v-bind:value="modelClass.name"></input>
        {{ modelClass.name }}
        <ul>
          <li v-for="association in modelClass.associations.nodes">
            <input type="checkbox" v-model="associationNames" v-bind:value="modelClass.name + '#' + association.name"></input>
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
  import Vue from 'vue'
  import mermaidAPI from 'mermaid'

  export default {
    data: function () {
      return {
        loaded: false,
        modelClasses: {},
        classNames: [],
        associationNames: [],
        text: '',
        type: 'mermaid',
        raw: ''
      }
    },
    methods: {
      load() {
        const QUERY = gql`
          query($exceptClasses: [String!], $exceptAssociations: [String!]) {
            application {
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
          }
        `
        this.$apollo.query({
          query: QUERY
        }).then((result) => {
          this.$data.raw = result.data
          this.$data.modelClasses = result.data.application.modelClasses
          this.$data.modelClasses.nodes.forEach((modelClass) => {
            this.$data.classNames.push(modelClass.name)
            modelClass.associations.nodes.forEach((association) => {
              this.$data.associationNames.push(modelClass.name + '#' + association.name)
            })
          })
          this.$data.loaded = true
        }).catch((error) => {
          alert(error)
        })
      },
      toggle(modelClass, e) {
        console.log(e)
        console.log(this)
      },
      getText() {
        console.log("getting")
        const QUERY = gql`
          query($type: String!, $classNames: [String!]!, $associationNames: [String!]!) {
            application {
              text(type: $type, targetClasses: $classNames, targetAssociations: $associationNames)
            }
          }
        `
        this.$apollo.query({
          query: QUERY,
          variables: {type: this.$data.type, classNames: this.$data.classNames, associationNames: this.$data.associationNames}
        }).then((result) => {
          console.log("got")
          this.$data.text = result.data.application.text
          this.$data.raw = result.data
        }).catch((error) => {
          alert(error)
        })
      },
      draw() {
        var parent = document.body//querySelector("#mermaidParent")
        //parent.innerHTML = ''
        var element = document.createElement("div")
        parent.appendChild(element)
        var insertSvg = function(svg, functions) {
          element.innerHTML = svg;
        }
        var graphDefinition = '' + this.$data.text;
        //graphDefinition = 'classDiagram\n\n\n\nA --> B'
        mermaidAPI.render('mermaidCanvas', graphDefinition, insertSvg)
      },
      reset() {
        this.$data.text = ''
      }
    },
    mounted() {
      mermaidAPI.initialize({startOnLoad: false})
      this.load()
    },
  }
</script>

<style scoped>
</style>
