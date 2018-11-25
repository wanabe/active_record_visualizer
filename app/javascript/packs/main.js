import Vue from 'vue'
import App from '../app.vue'
import ApolloClient from "apollo-boost"
import VueApollo from "vue-apollo"

Vue.use(VueApollo)

const apolloClient = new ApolloClient({
  uri: "http://localhost:3001/active_record_visualizer/graphql"
})
const apolloProvider = new VueApollo({
  defaultClient: apolloClient,
})

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('hello'))
  const app = new Vue({
    el,
    apolloProvider,
    render: h => h(App)
  })

  console.log(app)
})
